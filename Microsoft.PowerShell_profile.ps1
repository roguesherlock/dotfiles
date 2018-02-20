function gtd {
    Set-Location $HOME/Developer
}

function makeos ($ast = 'DUMBVM'){
    switch ($ast) {
    'ast1' {setx ASST 'ASST1'; break}
    'ast1' {setx ASST 'ASST1'; break}
    'ast1' {setx ASST 'ASST1'; break}
    default {Write-Error 'No such assignment exists!'; return;}
    }

    $BUILDDIR = $HOME+'/Developer/os161/shared/os161/kern/compile/'+$ASST
    $ROOTDIR = $HOME+'/Developer/os161/shared/os161/root'

    Set-Location $BUILDDIR
    bmake; if($?){bmake install}; if($?){Set-Location $ROOTDIR};
    Write-Output 'Done!'

}

Set-PSReadlineOption -TokenKind Number -ForegroundColor DarkMagenta
Set-PSReadlineOption -TokenKind Member -ForegroundColor DarkGray
