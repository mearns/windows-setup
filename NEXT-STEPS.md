## Revoke SSH Public Key

You already had an SSH public key installed on this system at `C:\Users\bmearns\.ssh\id_rsa.pub`. It has been backed up to:
> C:\Users\bmearns\sandbox\windows-setup\scripts\util\..\..\backups\id_rsa.pub-A6207A13D7F5E108250C92BFD10D00B9506E84136ECB40CA52F3BF7A4C5B6D19743E4F7BDB60C5F4EBACF418B2202F9A821541F012314BA720201744F1E27802
A new SSH Key Pair will be generated under `C:\Users\bmearns\.ssh`; it is recommended that you *revoke* your previous
SSH Public Key from any system that know about it, so that it can no longer be used. The old public key
(the one you should probably revoke) is:

> ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAvWLDlPzYuArHEV89ksGgRYqXy82Pu/USqtXGlpaASJ0VBbVMDWbOOdNegh45/Pq5lgyEtDlvUkgRtAwFgmi8AOD6tWMouk2oOIgnEc76sjnuMzFspW07+/7OSoQO32mUmFtMNP6ec0GNqVYy57igmaPVNvlfXIjCoXBaWPtPSn9MpqU1vmyQLPsYW5Xv7P7yZpNH6gaD3PVaJPq60Br0N8PtKxZ1lAHLuEVnqaOoSK4VNy2XGTYkOWEga0a8z5r4UUqT44pGeCnCHuU+ncwrA61M7G+WJLU6CWhchezGFtX/gNxvdayv0tv6qqc1HcvIrlqfabzpP6HOgzg2twby50bN8Sjat881EE87agvQPlpoLnMQ7PgWHrNj0aShkgmgMZjTjysvRficcrsygBYon8ZLC36XOWwqwMIzvWeu9OUea416gwf2g/D+z6fmc01dCw7cnHBtbEkzjqtKfK5Rrf6yFW18maVH3+aE7HGTC91s+s7KDmhPtBR3/yM+DK8OQoCMXO5GuiXAJC6D8vtR48opOp/KSsA92nDNdgh9Ue52RIgpL80wdLvrZaLMpM5rKZgmfBf96MjbNvn80KK1qASDAKIli3sPOx4BhPxLPPA8emC+CrhlrAYBl1jS/H5J6mCJ2CEOV+FN8r8LarPzJq78c6viW0ELqt7H2VFfiQ== bmearns@LT-DEV-BM1

## Publish SSH Public Key

Your new SSH key pair has been generated under `C:\Users\bmearns\.ssh`. You should now add your new public key
to whatever systems you need to authenticate with. Here are some suggestions:
* [Github](https://github.com/settings/keys)
* Gitlab (`https://${GITLAB-HOST}/profile/keys`)

Here is your new SSH public key:

> ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHp7x5FZgq7fgHhpVGDfiuNCAYP7AAnJWRBkJtWHVLa/f8AhlYGyYiorKjdO+tRIe7LvF6PeJzrYxTfmH4XqJ8k9QTH4qKNrxKcrDbHLPR5ZiMsXW6E/4+qpzekrTt3b1tgm2uGcn7p0sP4GmeWV52nS8i/UnIdL3P3x+Cmx+cdFazeewe14zqIeM4gz4eCdOcVwF+adCcjKPtQRaqJ7EJNJeTwMF58+OWJuWs+F9Ar1is5h1SzgCQ8r70yyA+Rb59ps/XudGC4JObm4YN3MS6wffNYP+kUz34Cv1Xq+1P4Efe+TY8On9rx73Z/C/sLZnPyducMTW0VNyIk03fov483afHvxIpIZ2d/2R5qwRS4DDzVj4OdMRrljf5HQux1aLGPg0dYkWL/4g4vAv+8ID5Gb4VAOra5CyzqFseKpyNXniQ6aCB61TwxvuJXm8pUseb90C/D/L7210XV9emMHcBPBv0LPTIkfv1UqZQrQ7wy76YzkayrWJZaVm+9aQ8xd43oUuM1I6T9YCqWbMiUbYySMKSYrf8VKUiGcHi+By4UdCLEBZ/2KyOx44Ht+17Nq2Q62NOuU5TD/3PuIzlM0Kv0YHubOR2QxH4yjTbffrD9kgBqLF48ilrHo6xPgJMy02LhjE1sSfgrBanIdBh7y8g2M59fJEtuiFazPn3AHf7oQ== bmearns@LT-DEV-BM1

