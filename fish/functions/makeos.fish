function makeos
    switch $argv[1]
    case 'ast1'
        set ASST 'ASST1'
    case 'ast2'
        set ASST 'ASST2'
    case 'ast3'
        set ASST 'ASST3'
    case '*'
        set ASST 'DUMBVM'
    end

    set BUILDDIR $HOME'/code/os161/kern/compile/'$ASST
    set ROOTDIR $HOME'/code/os161/root'

    cd $BUILDDIR
    bmake; and bmake install; and cd $ROOTDIR
    echo 'Done!'
end
