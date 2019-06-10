[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/fabriciofx/glint/blob/master/LICENSE.txt)


## Introduction

glint is a script to check your commit messages.


## Instructions

1. Download `glint.sh` and put it inside your project's git repository
2. Create a `.glint` configuration file. This file just contains a plain text
   file with a shell variable (`COMMIT_MSG_REGEX`) that represents a valid
   commit message regex (you can use the `.glint` in this repo as sample)
3. Install `glint.sh` as a git hook (optional)
```
$ glint.sh install
```


## Usage

There are several ways to use glint. You can:

- Install as a git hook and every time will do a commit, glint will run to check
if the commit message is valid
- Run over the log messages
```
$ git log --oneline | ./glint.sh
```


## License

The MIT License (MIT)

Copyright (c) 2019 Fabricio Barros Cabral

Permission is hereby granted, free of #charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
