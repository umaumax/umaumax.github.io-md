# binary

## edit binary by command
* [shell \- CLI: Write byte at address \(hexedit/modify binary from the command line\) \- Stack Overflow]( https://stackoverflow.com/questions/4783657/cli-write-byte-at-address-hexedit-modify-binary-from-the-command-line )

WARN: This is a great solution, but sadly, it doesn't work with BusyBox. BusyBox's implementation of dd doesn't support conv=notrunc (or conv=anything, for that matter).
NOTE: Maybe you can use python instead of dd command!
```
printf '\x31\xc0\xc3' | dd of=test_blob bs=1 seek=100 count=3 conv=notrunc
```

> status=none very useful when you don't want any statistics out of dd.

## binary diff
* [diff \- How do I compare binary files in Linux? \- Super User]( https://superuser.com/questions/125376/how-do-i-compare-binary-files-in-linux )

```
cmp -l $FILE1 $FILE2 | gawk '{printf "%08X %02X %02X\n", $1, strtonum(0$2), strtonum(0$3)}'
```
