import git
import os
import sys
import ctypes
from git import Repo
import tkinter as tk
from tkinter import simpledialog

cwd = os.getcwd()
local_repo = Repo(path=cwd)
local_branch = local_repo.active_branch.name
g = git.cmd.Git(cwd)

ROOT = tk.Tk()

changed_files = local_repo.head.commit.diff(None)
names = [diff.a_path for diff in changed_files]
splitted_names = "\n".join(names)

if not len(changed_files):
    ctypes.windll.user32.MessageBoxW(
        0, u"Nothing to commit, working tree clean.", u"Info", 0)
    sys.exit()

ROOT.eval('tk::PlaceWindow . center')
ROOT.withdraw()
ROOT.mainloop()
# the input dialog
commit_message = simpledialog.askstring(title="Git",
                                        prompt="Commit message for following changes: \n " + splitted_names)

if commit_message == None:
    ctypes.windll.user32.MessageBoxW(
        0, u"Commit cancelled.", u"Info", 0)
    sys.exit()

local_repo.git.add(A=True)
local_repo.git.commit(m=commit_message)

command = "git push origin " + local_branch
g.execute(command)

ctypes.windll.user32.MessageBoxW(
    0, u"Active branch "+local_branch+" is pushed to origin/"+local_branch, u"Info", 0)
