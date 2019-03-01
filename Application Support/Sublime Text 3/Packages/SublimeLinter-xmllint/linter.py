from SublimeLinter.lint import Linter, util


class Xmllint(Linter):
    cmd = '/usr/local/bin/xmllint.1 --noout ${args} -'
    regex = r'^-:(?P<line>\d+):.+?: (?P<message>[^\r\n]+)(\r?\n[^\r\n]*\r?\n(?P<col>[^\^]*)\^)?'
    multiline = True
    error_stream = util.STREAM_STDERR
    defaults = {
        'selector': 'text.xml'
    }
