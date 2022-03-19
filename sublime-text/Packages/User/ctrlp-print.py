import sublime, sublime_plugin
import re


class CtrlpPrintCommand(sublime_plugin.TextCommand):
    """ This method will double as a print statement as well as a documentation
        generator """
    def run(self, edit):
        # set print type based on lang
        lang = str(self.view.scope_name(0))
        print("lang =", lang)
        pyprint_langs = ['python', 'markdown']
        soutprintln_langs = [ 'java', 'flexlex']
        
        # if 'python' in lang:
        if any((l in lang) for l in pyprint_langs):
            lang = 'python'
            var_print = "print(\"{0} =\", {0})"
            p_print = "print(f\"\")"
        elif any((l in lang) for l in soutprintln_langs):
            lang = 'java'
            var_print = "System.out.println(\"{0} = \" + {0});"
            p_print = "System.out.println(\"\");"
        elif 'ts' in lang:
            lang = 'ts'
            var_print = "console.log(\"{0} = \" + {0});"
            p_print = "console.log(\"\");"
        elif 'jsx' in lang:
            lang = 'jsx'
            var_print = "console.log(\"{0} = \", {0});"
            p_print = "console.log(\"\");"
        elif 'html' in lang:
            lang = 'html'
            var_print = "console.log(\"{0} = \", {0});"
            p_print = "console.log(\"\");"
        elif 'c' in lang:
            lang = 'c'
            var_print = "printf(\"{0} = %d\\n\", {0});"
            p_print = "printf(\"%d\\n\", );"
        else:
            return
            
        for region in self.view.sel():
            if region.size() == 0:
                # then nothing is selected
                self.view.replace(edit, region, p_print)
                self.view.run_command("move", {"by": "characters", "forward": True})
                self.view.run_command("move", {"by": "characters", "forward": False})
                self.view.run_command("move", {"by": "characters", "forward": False})
                if lang in ['java']:
                    self.view.run_command("move", {"by": "characters", "forward": False})
                if lang in ['html']:
                    self.view.run_command("move", {"by": "characters", "forward": False})
            else:
                # we have something to print
                selection = self.view.substr(region)
                # check if we are attempting to generate docs
                if self._isdocs(lang, selection):
                    self._generate_docs(edit, region, lang, selection)
                    continue
                # first check if it is the only thing in line
                line = self.view.substr(self.view.line(self.view.sel()[0]))
                index = line.find(selection)
                ln = len(selection)
                rest_of_line = (line[:index] + line[index+ln:]).strip()
                if rest_of_line == '':
                    # then this is the only thing in the line
                    self.view.replace(edit, region, var_print.format(selection))
                    self.view.run_command("move", 
                        {"by": "characters", "forward": True}
                    )
                else:
                    # then there are more things on this line
                    tabs = line[:line.find(line.lstrip())]
                    # check if we must indent
                    if line.strip().startswith(('if', 'else', 'elif', 'while', 'for', 'def')):
                        tabs += '\t'
                    a = min(region.a, region.b)
                    end = a + len(line[index:])
                    self.view.insert(edit, end, '\n'+tabs+var_print.format(selection))
    def _isdocs(self, lang, selection):
        if lang == 'java':
            # return re.search('\w+ +\w+ *\(.*\) *\{', selection) != None
            # return re.search('\S*\s\S*\s\S*\(.*\)\s\{', selection) != None
            # return re.search('\S*\s\S*\s\S*\((.|\n)*\)\s\{', selection) != None
            return re.search('\S*\s\S*\((.|\n)*\)\s\{', selection) != None
        return False
    def _extract_params(self, params):
        word = ""
        alist = []
        depth = 0
        for c in params:
            if c == '<':
                depth += 1
            elif c == '>':
                depth -= 1
            if depth > 0:
                word += c
            else:
                if c == ',':
                    alist.append(word)
                    word = ""
                else:
                    word += c
        alist.append(word)
        if alist == ['']:
            alist = []
        return alist

    def _generate_docs(self, edit, region, lang, s):
        if lang == 'java':
            p1 = s.find('(')
            p2 = s.find(')')
            return_type = s[:p1].split(' ')[-2]
            isvoid = return_type == 'void' or return_type == 'public'
            params = s[p1+1:p2]
            params = self._extract_params(params)
            line = self.view.substr(self.view.line(self.view.sel()[0]))
            numspaces = re.match('\s*', line).end()
            indent = ' ' * numspaces # indentation
            # define indentation
            # let's start generating the text
            documentation = \
                "{0}/**\n".format(indent) + \
                "{0} * description\n".format(indent)
            if len(params) != 0 or not isvoid:
                documentation += "{0} *\n".format(indent)
            for param in params:
                *vartype, varname = param.strip().split(' ') # in case of new line characters
                vartype = ' '.join(vartype)
                documentation += "{0} * @param {1} the {2}.\n".format(indent, varname, vartype)
            if not isvoid:
                documentation += "{0} * @return {1}.\n".format(indent, return_type)
            documentation += indent + " */\n"

            # add the documentation
            self.view.insert(edit, min(region.a, region.b) - numspaces, documentation)

class MoveLinesCommand(sublime_plugin.TextCommand):
    def run(self, edit, amount):
        amount, direction = int(abs(amount)), amount < 0
        for _ in range(amount):
            self.view.run_command("move", {"by": "lines", "forward": direction})


class ScrollAndMoveCommand(sublime_plugin.TextCommand):
    def run(self, edit, amount):
        self.view.run_command("scroll_lines", {"amount": amount } )
        amount, direction = int(abs(amount)), amount < 0
        for _ in range(amount):
            self.view.run_command("move", {"by": "lines", "forward": direction})


_dict2curly_re = re.compile(r'\w+=')
_curly2dict_re = re.compile(r"""('\w+': )|("\w+": )""")
class KwargConverter():
    
    ####################
    # MAPPING CONDITIONS
    ####################
    # {'a': 0, 'b': 1}
    def is_curly(self, s: str):
        return s.startswith('{') and s.endswith('}')
    # dict(a=0, b=1)
    def is_dict(self, s: str):
        return s.startswith('dict(') and s.endswith(')')
    # **{'a': 0, 'b': 1}    
    def is_star(self, s: str):
        return s.startswith('**{') and s.endswith('}')
    # a=0, b=1
    def is_kwargs(self, s: str):
        return '=' in s

    #################################
    # star -> curly -> kwargs -> dict
    #################################
    def _star2curly(self, star: str):
        """ **{'a': 0, 'b': 1} -> {'a': 0, 'b': 1} """
        return star[2:]
    def _curly2kwargs(self, curly: str):
        """ {'a': 0, 'b': 1} -> a=0, b=1 """
        matches = [ m for m in _curly2dict_re.finditer(curly) ]
        kwargs = curly
        for m in matches[::-1]:
            a, b = m.span()
            kwargs = kwargs[:a] + f"{curly[a+1:b-3]}=" + kwargs[b:]
        return kwargs[1:-1]
    def _kwargs2dict(self, s: str):
        """ a=0, b=1 -> dict(a=0, b=1) """
        return 'dict(' + s + ')'

    #################################
    # dict -> kwargs -> curly -> star
    #################################
    def _dict2kwargs(self, dict: str):
        """ dict(a=0, b=1) -> a=0, b=1 """
        return dict[5:-1]
    def _kwargs2curly(self, kwargs: str):
        """ a=0, b=1 -> {'a': 0, 'b': 1} """
        matches = [ m for m in _dict2curly_re.finditer(kwargs) ]
        curly = kwargs
        for m in matches[::-1]:
            a, b = m.span()
            curly = curly[:a] + f"'{kwargs[a:b-1]}': " + curly[b:]
        return '{' + curly + '}'
    def _curly2star(self, curly: str):
        """ {'a': 0, 'b': 1} -> **{'a': 0, 'b': 1} """
        return '**' + curly

    ####################################
    # dict -> curly | curly -> dict
    ####################################
    def dict2curly(self, dict: str):
        """ dict(a=0, b=1) -> {'a': 0, 'b': 1} """
        kwargs = self._dict2kwargs(dict)
        curly = self._kwargs2curly(kwargs)
        return curly
    def curly2dict(self, curly: str):
        """ {'a': 0, 'b': 1} -> dict(a=0, b=1) """
        kwargs = self._curly2kwargs(curly)
        dict = self._kwargs2dict(kwargs)
        return dict

    ####################################
    # kwargs -> star | star -> kwargs
    ####################################
    def kwargs2star(self, kwargs: str):
        """ a=0, b=1 -> **{'a': 0, 'b': 1} """
        curly = self._kwargs2curly(kwargs)
        star = self._curly2star(curly)
        return star
    def star2kwargs(self, star: str):
        """ **{'a': 0, 'b': 1} -> a=0, b=1 """
        curly = self._star2curly(star)
        kwargs = self._curly2kwargs(curly)
        return kwargs

_camel2snake_re = re.compile(r'(?<!^)(?=[A-Z])')
class CaseConverter():
    def camel2snake(self, camel_case: str) -> str:
        return _camel2snake_re.sub('_', camel_case).lower()
    def snake2camel(self, snake: str) -> str:
        return ''.join(s.title() for s in snake.split('_'))
    def is_snake(self, s: str):
        return s.lower() == s

class ImportConverter():
    def is_path(self, s: str):
        return '/' in s and s.endswith('.py')
    def path2import(self, s: str):
        """ a/b/c.py -> from a.b import c """
        """ a/b/src/c/d/e.py -> from c.d import e """
        index = s.rfind('/')
        start, end = s[:index], s[index+1:] # start -> a/b; end -> c.py
        start = start.replace('/', '.')     # start -> a.b
        end = end[:-len('.py')]             # end -> c
        if 'src' in start:
            start = start[start.find('src') + 4:]
        return f'from {start} import {end}'

class CasesCommand(sublime_plugin.TextCommand):

    def convert(self, s):

        kwarg_converter = KwargConverter()
        if kwarg_converter.is_curly(s):
            return kwarg_converter.curly2dict(s)
        elif kwarg_converter.is_dict(s):
            return kwarg_converter.dict2curly(s)
        elif kwarg_converter.is_star(s):
            return kwarg_converter.star2kwargs(s)
        elif kwarg_converter.is_kwargs(s):
            return kwarg_converter.kwargs2star(s)
        
        import_converter = ImportConverter()
        if import_converter.is_path(s):
            return import_converter.path2import(s)
        
        case_converter = CaseConverter()
        if case_converter.is_snake(s):
            return case_converter.snake2camel(s)
        else:
            return case_converter.camel2snake(s)

    def run(self, edit):
        for region in self.view.sel():
            if region.size() == 0:
                continue
            selection = self.view.substr(region)
            new_text = self.convert(selection)
            # paste over current text
            self.view.replace(edit, region, new_text)


class MultilineCommentCommand(sublime_plugin.TextCommand):
    def run(self, edit, s):
        for region in self.view.sel():
            self.view.insert(edit, region.a, s)
            self.view.run_command("duplicate_line")
            self.view.run_command("move", {"by": "lines", "forward": False})
            self.view.run_command("insert", {"characters": "\n"})


class InsertNumbersCommand(sublime_plugin.TextCommand):
    def run(self, edit, num):
        for region in self.view.sel():
            self.view.insert(edit, region.a, str(num))
            num += 1


class HighlightMoveCommand(sublime_plugin.TextCommand):

    def get_line(self, row):
        curr = self.view.text_point(row, 0)
        region = sublime.Region(curr, curr)
        line = self.view.substr(self.view.line(region))
        return line

    def run(self, edit, right):
        if len(self.view.sel()) > 1:
            # then we are having multiple cursors, implement normal ctrl
            if right:
                self.view.run_command("move", {"by": "word_ends", "forward": True})
            else:
                self.view.run_command("move", {"by": "words", "forward": False})
            return

        # else just one region, do highlight movement
        region = self.view.sel()[0]

        # get the entire line as well as the row, col
        line = self.view.substr(self.view.line(region))
        row, col = self.view.rowcol(region.a)
        selected_ln = len(self.view.substr(region))
        a, b = region.a, region.b

        if right:
            start = col + selected_ln
            end = -1
        else:
            start = 0
            end = col
        # iterate 10 times until line found
        for i in range(1, 10):
            # get tokens in line
            line = line + " "
            tokens = [ 
                token 
                for token in re.split(r"\W+", line[start:end]) 
                if token != ''
            ]
            # check if there are tokens
            if tokens == []:
                # there are no tokens in this line
                # set next line
                row += 1 if right else -1
                col = 0
                start = 0
                end = -1
                line = self.get_line(row)
            else:
                break

        if right:
            # we have found our token
            token = tokens[0]
            # get the index of the token from col
            index = line.find(token, start)
            # this is the index of the token in this line
            a = self.view.text_point(row, index)
            b = a + len(token)
        else:
            # we have found our token
            token = tokens[-1]
            # get the index of the token from col
            index = line.rfind(token, start, end)
            # this is the index of the token in this line
            a = self.view.text_point(row, index)
            b = a + len(token)
        
        # we expect that a and b has been set, this becomes our new region
        r = sublime.Region(a, b) 
        # clear current selection
        self.view.sel().clear()
        # add new region to selection
        self.view.sel().add(r)
