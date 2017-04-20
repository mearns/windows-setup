# Brian Mearns' Windows Setup Scripts

This is a hacky set of scripts to make it easier to get a new windows install setup the way I
need for working.

Seriously, it's hacky.

It might not *actually* work on a clean system. Some things might not be on the path in the same process
that installed them, and are needed for future operations (such as `npm` or `apm`). You best bet is
to comment out the steps that have already completed, maybe in `scripts/bootstrap-00.ps1`, and then
run again, maybe in a new shell.

It at least tries to backup some stuff to the `backups/` directory before blowing it away.
When it does, it tags it with the hash of the contents, and adds a line in `backups/__manifest.txt`
file describing the backup, so you might actually be able to undo it if you need to.

