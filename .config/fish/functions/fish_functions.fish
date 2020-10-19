function gm
    slack_presence "good morning 🙂"
    slack_presence "" --set-status
end

function wfh
    slack_presence "good morning 🙂, wfh"
    slack_presence "" --set-status
end

function gn
    slack_presence "signing out, good night."
    slack_presence "afk :afk:" --set-status
end

function host
    curl -F "file=@"(ls $argv[1]) "https://file.io/"
end

function ignore
    echo 1 >~/.ignore
end

function dontignore
    echo 0 >~/.ignore
end
