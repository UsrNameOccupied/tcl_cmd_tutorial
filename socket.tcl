#!/usr/bin/tclsh
set socketid [socket localhost 6969];
# 行刷缓存
# fconfigure $socketid -buffering line;
puts -nonewline $socketid "WORLD!";
flush $socketid;
gets $socketid msg;
puts $msg;
