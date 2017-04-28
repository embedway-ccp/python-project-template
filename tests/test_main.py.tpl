# -*- coding: utf-8 -*-
from pytest import raises

import pytest

from $package import metadata
from ${package}.main import main

parametrize = pytest.mark.parametrize


@parametrize('helparg', ['-h', '--help'])
def test_help(helparg, capsys):
    with raises(SystemExit) as exec_info:
        main(['progname', helparg])
    out, err = capsys.readouterr()
    # Should have printed some sort of usage message. We don't
    # need to explicitly test the content of the message.
    assert 'usage' in out
    # Should have used the program name from the argument
    # vector.
    assert 'progname' in out
    # Should exit with zero return code.
    assert exec_info.value.code == 0


@parametrize('versionarg', ['-v', '--version'])
def test_version(versionarg, capsys):
    ret = main(['progname', versionarg])
    out, err = capsys.readouterr()
    # Should print out version.
    assert '{0} {1}\n'.format(metadata.project, metadata.version) in out
    # Should exit with zero return code.
    assert ret == 0
