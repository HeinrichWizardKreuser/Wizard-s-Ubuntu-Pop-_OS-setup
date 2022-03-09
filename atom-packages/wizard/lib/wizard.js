const {CompositeDisposable} = require('atom')

module.exports = {
  subscriptions: null,

  activate () {
    this.subscriptions = new CompositeDisposable()
    this.subscriptions.add(atom.commands.add('atom-workspace',
      {'wizard:convert': () => this.convert()})
    )
  },

  deactivate () {
    this.subscriptions.dispose()
  },

  // convert is some random function we have (name doesn't matter.)
  // we call convert() to convert some text we may or may not have highlighted
  convert() {
    // get editor
    const editor = atom.workspace.getActiveTextEditor()
    // check if editor is not null
    if (editor) {
      // get selected text
      const selection = editor.getSelectedText()
      // PYTHON
      if (editor.getTitle().endsWith(".py")) {
        // Print statement
        if (selection.length == 0) {
          editor.insertText("print(\"\")");
          editor.moveLeft(2)
        } else {
          if (selection.indexOf("(") !== -1) {
            // turn f(x) into print("f("+str(x)+") = " + str(f(x)))
            var start = selection.substring(0, selection.indexOf("(")+1);
            var middle = selection.substring(selection.indexOf("(")+1, selection.indexOf(")"));
            var end = selection.substring(selection.indexOf(")")+1);
            editor.insertText("print(\"" + start + "\"+str(" + middle + ")" + end +"+\") = \" + " + "str(" + selection + ")))");
            editor.backspace();
          } else {
            editor.backspace();
            editor.insertText("print(\"" + selection + " = \" + " + "str(" + selection + "))");
          }
        }
      }
      // JAVA
      else if (editor.getTitle().endsWith(".java")) {
        // Print statement
        if (selection.length == 0) {
          editor.insertText("System.out.println(\"\")");
          editor.moveLeft(2)
          // do nothing
        } else {
          editor.backspace();
          editor.insertText("System.out.println(\"" + selection + " = \" + " + selection + ")");
        }
      }
      // C
      else if (editor.getTitle().endsWith(".c")) {
        // Print statement
        if (selection.length == 0) {
          editor.insertText("printf(\"%s\\n\", );");
          editor.moveLeft(9)
          // do nothing
        } else {
          editor.backspace();
          editor.insertText("printf(\""+selection+" = %s\\n\", " + selection + ");");
        }
      }
    }
  }
}
