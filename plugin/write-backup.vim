" Vim global plugin for writing backup files to a dedicated directory
"
" Last Change:  2009-04-25
" Maintainer:   Simon Hengel <simon.hengel@wiktory.org>
" License:      This file is placed in the public domain.
"
" Put this file in your plugin directory (e.g. ~/.vim/plugin/) and backup
" files will be written to a dedicated directory. By default ~/.vimbak is
" used. You may change this by setting write_backups_backup_dir.

" only load this plugin once
if exists("loaded_write_backups")
    finish
endif
let loaded_write_backups = 1

" set compatibility to Vim defaults
let s:save_cpo = &cpo
set cpo&vim

" put all backup files into ~/.vimbak, you may change this to your liking
if !exists("write_backups_backup_dir")
    let write_backups_backup_dir = expand("~/.vimbak")
endif

" enable backups
set backup
let &backupdir = write_backups_backup_dir

" create backupdir if it does not exist yet
if !isdirectory(write_backups_backup_dir)
    if exists("*mkdir")
        call mkdir(write_backups_backup_dir)
        echo "created backupdir" write_backups_backup_dir
    else
        echo "please create the directory" write_backups_backup_dir
    endif

    echo ""
    echo "for more privacy add the following to your crontab:"
    echo "23 * * * * find" write_backups_backup_dir "-type f -mmin +2880 -exec rm {} \\;"
endif

" restore compatibility
let &cpo = s:save_cpo
