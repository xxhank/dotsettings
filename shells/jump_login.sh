#!/usr/bin/expect

set timeout 10

set JUMP_USER [lindex $argv 0]
set JUMP_HOST [lindex $argv 1]
set JUMP_PWD [lindex $argv 2]

set TARTGET_USER [lindex $argv 3]
set TARTGET_HOST [lindex $argv 4]
set TARTGET_PWD [lindex $argv 5]

# puts stdout  $JUMP_USER
# puts stdout  $JUMP_HOST
# puts stdout  $JUMP_PWD
# puts stdout  $TARTGET_HOST
# puts stdout  $TARTGET_USER
# puts stdout  $TARTGET_PWD

# 登录跳板机
# spawn ssh -l $JUMP_USER $JUMP_HOST
# expect {
#     "yes/no" {send "yes\r";exp_continue;}
#     "*password:*" { send "$JUMP_PWD\r" }
# }

# # 登录内网
# expect "*$JUMP_USER@*" {send "ssh -l $TARTGET_USER $TARTGET_HOST\r"}
# expect {
#     "yes/no" {send "yes\r";exp_continue;}
#     "*password:*" { send "$TARTGET_PWD\r"; }
# }

# expect "$TARTGET_USER*~]*" { send "cd /data/logs/openresty/\r";  }

# interact

# 登录跳板机
spawn ssh -l $JUMP_USER $JUMP_HOST
expect {
        "yes/no" {send "yes\r";exp_continue;}
         "*password:*" { send "$JUMP_PWD\r" }
        }
# 登录内网
expect "*$JUMP_USER@*" {send "ssh -l $TARTGET_USER $TARTGET_HOST\r"}
expect {
        "yes/no" {send "yes\r";exp_continue;}
        "*password:*" { send "$TARTGET_PWD\r" }
        }
interact