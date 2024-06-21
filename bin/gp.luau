local process = require("@lune/process")
local stdio = require("@lune/stdio")
local task = require("@lune/task")

local gitLog = require("gl.luau")
type Commit = gitLog.Commit

local function dots(count: number)
    for i = 1, count do
        stdio.write(".")
        task.wait(0.2)
    end
end

function main(args: {string})
    print("Unpushed commits:")

    local childExit = gitLog.main({"origin/main..HEAD"})
    if childExit ~= 0 then
        return childExit
    end

    stdio.write("Pushing to remote")
    task.spawn(dots, 3)
    local pushChild = process.spawn("git", {"pull", "--rebase", "&&", "git", "push"}, {
        shell = true
    })
    if not pushChild.ok then
        stdio.ewrite("\r" .. pushChild.stderr)
        return pushChild.code
    end

    stdio.write(stdio.color("green") .. " done!" .. stdio.color("reset") .. "\n")

    return 0
end

return process.exit(main(process.args))