import pdb

class Config(pdb.DefaultConfig):
  bg = 'dark'
  # the prompt in interactive mode
  prompt = '(Pdb++) '
  encoding = 'utf-8'
  sticky_by_default = True

