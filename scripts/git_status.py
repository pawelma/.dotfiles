# -*- coding: utf-8 -*-

# borrowed from:
# https://github.com/jaspernbrouwer/powerline-gitstatus/blob/master/powerline_gitstatus/segments.py

from subprocess import PIPE, Popen
from colored import fg, bg
import os, re, string, sys

class GitStatusSegment:

    def execute(self, command):
        # print('Executing command: %s' % ' '.join(command))

        proc = Popen(command, stdout=PIPE, stderr=PIPE)
        out, err = [item.decode('utf-8') for item in proc.communicate()]

        # if out:
        #     print('Command output: %s' % out.strip(string.whitespace))
        # if err:
        #     print('Command errors: %s' % err.strip(string.whitespace))

        return (out.splitlines(), err.splitlines())

    def get_base_command(self, use_dash_c):
        if use_dash_c:
            return ['git', '-C', cwd]

        cwd = self.gitdir

        while cwd and cwd != os.sep:
            self.gitdir = os.path.join(cwd, '.git')

            if os.path.isdir(self.gitdir):
                return ['git', '--git-dir=%s' % self.gitdir, '--work-tree=%s' % cwd]

            cwd = os.path.dirname(cwd)

        return None

    def parse_branch(self, line):
        if not line:
            return ('', False, 0, 0)

        if line.startswith('## '):
            line = line[3:]

        match = re.search('^Initial commit on (.+)$', line)
        if match is not None:
            return (match.group(1), False, 0, 0)

        match = re.search('^(.+) \(no branch\)$', line)
        if match is not None:
            return (match.group(1), True, 0, 0)

        match = re.search('^(.+?)\.\.\.', line)
        if match is not None:
            branch = match.group(1)

            match = re.search('\[ahead (\d+), behind (\d+)\]$', line)
            if match is not None:
                return (branch, False, int(match.group(2)), int(match.group(1)))
            match = re.search('\[ahead (\d+)\]$', line)
            if match is not None:
                return (branch, False, 0, int(match.group(1)))
            match = re.search('\[behind (\d+)\]$', line)
            if match is not None:
                return (branch, False, int(match.group(1)), 0)

            return (branch, False, 0, 0)

        return (line, False, 0, 0)

    def parse_status(self, lines):
        staged    = len([True for l in lines if l[0] in 'MRC' or (l[0] == 'D' and l[1] != 'D') or (l[0] == 'A' and l[1] != 'A')])
        unmerged  = len([True for l in lines if l[0] == 'U' or l[1] == 'U' or (l[0] == 'A' and l[1] == 'A') or (l[0] == 'D' and l[1] == 'D')])
        changed   = len([True for l in lines if l[1] == 'M' or (l[1] == 'D' and l[0] != 'D')])
        untracked = len([True for l in lines if l[0] == '?'])

        return (staged, unmerged, changed, untracked)

    def parse_rebase_status(self):
        step = None
        total = None
        current = None
        if os.path.isdir(os.path.join(self.gitdir, 'rebase-merge')):
            step = int(open(os.path.join(self.gitdir, 'rebase-merge', 'nmsgnum')).read())
            total = int(open(os.path.join(self.gitdir, 'rebase-merge', 'end')).read())
            current = open(os.path.join(self.gitdir, 'rebase-merge', 'head-name')).read()
        if os.path.isdir(os.path.join(self.gitdir, 'rebase-apply')):
            step = int(open(os.path.join(self.gitdir, 'rebase-apply', 'next')).read())
            total = int(open(os.path.join(self.gitdir, 'rebase-apply', 'last')).read())
            if os.path.isfile(os.path.join(self.gitdir, 'rebase-apply', 'rebasing')):
                current = 'rebasing'
            else:
                current = 'rebasing (apply)'
        return (step, total, current)


    def print_colored(self, message, color):
        sys.stdout.write(color + message)


    def build_segments(self, branch, detached, tag, behind, ahead, staged, unmerged, changed, untracked, stashed):
        step = None
        if detached:
            step, total, current = self.parse_rebase_status()
            if current:
                branch = current
            color = bg('red')
        elif staged or unmerged or changed or untracked:
            color = bg('yellow')
        else:
            color = bg('green')

        sys.stdout.write(branch)
        sys.stdout.write(" ")

        if tag:
            self.print_colored(' %s' % tag, color)
        if behind:
            self.print_colored(' ↓%d' % behind, color)
        if ahead:
            self.print_colored(' ↑%d' % ahead, color)
        if staged:
            self.print_colored(' ●%d' % staged, color)
        if unmerged:
            self.print_colored(' ✖%d' % unmerged, color)
        if changed:
            self.print_colored(' ✚%d' % changed, color)
        if untracked:
            self.print_colored(' …%d' % untracked, color)
        if stashed:
            self.print_colored(' ⚑%d' % stashed, color)
        if step:
            self.print_colored(' REBASE[%d/%d]' % (step, total), color)

    def __init__(self, use_dash_c=False, show_tag=True):
        # print('Running gitstatus %s -C' % ('with' if use_dash_c else 'without'))
        self.gitdir = os.getcwd()
        base = self.get_base_command(use_dash_c)

        if not base:
            return base

        status, err = self.execute(base + ['status', '--branch', '--porcelain'])

        if err and ('error' in err[0] or 'fatal' in err[0]):
            return

        branch, detached, behind, ahead = self.parse_branch(status.pop(0))

        if not branch:
            return

        if branch == 'HEAD':
            status, err = self.execute(base + ['rev-parse', '--short', 'HEAD'])
            if err:
                return
            branch = status.pop(0)

        staged, unmerged, changed, untracked = self.parse_status(status)

        stashed = len(self.execute(base + ['stash', 'list', '--no-decorate'])[0])

        if show_tag:
            tag, err = self.execute(base + ['describe', '--tags', '--abbrev=0'])

            if err and ('error' in err[0] or 'fatal' in err[0]):
                tag = ''
            else:
                tag = tag[0]
        else:
            tag = ''

        self.build_segments(branch, detached, tag, behind, ahead, staged, unmerged, changed, untracked, stashed)


GitStatusSegment()
