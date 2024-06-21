local process = require("@lune/process")
local DateTime = require("@lune/datetime")
local stdio = require("@lune/stdio")

local function map<K, V, R>(tbl: {[K]: V}, fn: (K, V) -> R): {[K]: R}
    local ref = tbl
    for key, value in tbl do
        ref[key] = fn(key, value)
    end

    return ref
end

export type Commit = {
    hash: string,
    author: string,
    message: string,
    date: DateTime.DateTime,
}

local function formatCommits(_, commit): string
    local dim = function(str) return stdio.style("dim") .. str .. stdio.style("reset") end
    return string.format(
        `{dim("•")} %s {dim("→")} %s`,
        commit.hash:sub(1, 7),
        stdio.color("yellow") .. commit.message .. stdio.color("reset")
    )
end 

local function outputToCommit(_, line)
    local parts = line:split("{{SEP}}")

    local hash = parts[1]:gsub("* ", "")
    local message = parts[2]
    local isoDate = parts[3]:gsub("[()]", "")
    local authorName = parts[4]:gsub("[<>]", "")

    return {
        hash = hash,
        message = message,
        date = DateTime.fromIsoDate(isoDate),
        author = authorName,
    }
end

function main(args: {string?})
    local range = args[1]
    local gitLogChild = process.spawn(
        "git",
        {
            "log",
            "--graph",
            "--pretty=format:%h{{SEP}}%s{{SEP}}(%cI){{SEP}}<%an>",
            range or "HEAD~5..HEAD",
        }
    )

    if not gitLogChild.ok then
        stdio.ewrite(gitLogChild.stderr)
        return gitLogChild.code
    end

    local commits: { Commit } = map(gitLogChild.stdout:split("\n"), outputToCommit)
    local formattedList = map(commits, formatCommits)

    print(table.concat(formattedList, "\n"))
    return 0
end

return {
    formatCommits = formatCommits,
    outputToCommit = outputToCommit,
    map = map,
    main = main
}
