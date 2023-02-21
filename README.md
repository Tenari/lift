# %lift

an urbit workout tracker

## dev

- make sure you have ruby on your system
- make sure there's a fakezod in the dir `zod` at one level above this directory
- `|merge %lift our %garden` in fakezod
- `|mount %lift` in fakezod
- `rm -rf ../zod/lift/*` (empty out the lift dir in your fakezod
- from this dir (`lift`), run `./rebuild.sh` (you may have to `chmod +x rebuild.sh` first)
- `|commit %lift` in your fakezod
- `|revive %lift` in your fakezod
- now to update the code, simply run `./rebuild.sh` from the lift dir and `|commit %lift` in your fakezod and go to http://localhost/apps/lift to see the change
