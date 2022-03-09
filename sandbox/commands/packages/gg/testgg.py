import unittest
import shlex
import gg


""" assert that override is optional """
class OverrideFailed(Exception):
    pass
def vsys(cmd):
    raise OverrideFailed()
gg.vsys = vsys
try:
    gg.vsys('test')
    raise Exception('method override not working')
except OverrideFailed:
    pass

""" override vsys """
def vsys(cmd):
    return cmd
gg.vsys = vsys

""" constants """
MSG = 'some message'
FILE1 = 'testgg.py'
FILE2 = 'gg.py'


class GcTestCase(unittest.TestCase):
    
    def expect(self, argv, expected):
        self.assertEqual(gg.main(*argv), expected)
        print(f"")
        if isinstance(expected, tuple):
            expected = '|\n  |'.join(expected)
        cmd = ('gc ' + ' '.join(argv)).strip()
        print(f"$ |{cmd}| ->\n  |{expected}|")
    
    def test1_gs(self):
        # |gc| -> |git status|
        self.expect([], 'git status')
    
    def test2_ga(self):
        self.expect(['.'], f'git add .')
        # |gc file1| -> |git add file1|
        self.expect([FILE1], f'git add {FILE1}')
        # |gc file1 file2| -> |git add file1 file2|
        self.expect([FILE1, FILE2], f'git add {FILE1} {FILE2}')


    def _single_messages(self):
        yield '...'
        yield 'x'
        yield 'somemessage'

    def _multiple_messages(self):
        yield 'some message'
        yield 'some quite long and extranious message'


    def _test_gc(self, msg):
        expected = f'git commit -m "{msg}"'
        self.expect(msg.split(' '), expected)

    def test3_gc_1_single(self):
        for msg in self._single_messages():
            self._test_gc(msg)

    def test3_gc_2_mutliple(self):
        for msg in self._multiple_messages():
            self._test_gc(msg)

    def test3_gc_3_quotes(self):
        for msg in self._multiple_messages():
            msg += " with a 'single' quote"
            self._test_gc(msg)


    def _test_gg(self, msg, *files):
        files = ' '.join(files)
        expected = (f'git add {files}', 
                    f'git commit -m "{msg}"')
        self.expect((files + ' ' + msg).split(' '), expected)

    def test4_gg_1file(self):
        for msg in self._single_messages():
            self._test_gg(msg, FILE1)
        for msg in self._multiple_messages():
            self._test_gg(msg, FILE1)
        for msg in self._multiple_messages():
            msg += " with a 'single' quote"
            self._test_gg(msg, FILE1)

    def test4_gg_2files(self):
        for msg in self._single_messages():
            self._test_gg(msg, FILE1, FILE2)
        for msg in self._multiple_messages():
            self._test_gg(msg, FILE1, FILE2)
        for msg in self._multiple_messages():
            msg += " with a 'single' quote"
            self._test_gg(msg, FILE1, FILE2)


if __name__ == '__main__':
    unittest.main()
