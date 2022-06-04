#############################
#Commentary for multiple lines
#############################

#alias "%%"='eval $(: << "COMMENT" $@ COMMENT)'
#alias "%"='eval : << "COMMENT"'
#alias "%%"='eval COMMENT'
#alias "%"='eval : << %%'

alias "%"='eval : <<%%'