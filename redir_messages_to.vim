" redir_messages_to.vim
"
" Based on the TabMessage function/command combo found here:
" http://www.jukie.net/~bart/conf/vimrc
"

function! RedirMessagesTo(newcmd, cmd)
"
" Redirects messages generated by executing the specified Ex command
" into a new tab or window.
"
" Examples:
"   RedirMessagesTo('tabnew', 'ls')  " Exec :ls and send output to new tab
"   RedirMessagesTo('new', 'ls')     " Exec :ls and send output to new window
"   RedirMessagesTo('vnew', 'ls')    " Exec :ls and send output to new window
"                                    " (vertically split)
"
" Commands are defined immediately below for common cases.
"
    " Redirect messages to a variable.
    "
    redir => message

    " Execute the specified Ex command.
    "
    silent execute a:cmd

    " Turn off redirection.
    "
    redir END

    " Open a new tab or window by executing the specified
    " 'new' command (:tabnew for a tab, or just :new for a window).
    "
    silent execute a:newcmd

    " Place the messages in the buffer of the new tab or window.
    "
    silent put=message

    " Mark the buffer as unmodified to avoid annoying
    " warnings about exiting without saving.
    "
    set nomodified

endfunction

" Create commands to make the redirect function easy to use.
"
command! -nargs=+ -complete=command TabMessage call RedirMessagesTo('tabnew', <q-args>)
command! -nargs=+ -complete=command WinMessage call RedirMessagesTo('new',    <q-args>)

" end redir_messages_to.vim