local process = require("@lune/process")
local stdio = require("@lune/stdio")

local dim = function(str) return stdio.style("dim") .. str .. stdio.style("reset") end

function main(args: {string})
    local gitStatusChild = process.spawn("git", {"status", table.unpack(args)})
    if not gitStatusChild.ok then
        stdio.ewrite(gitStatusChild.stderr)
        return gitStatusChild.code
    end

    local statusDiff: {{ file: string, type: string }} = {}
    local statusLines = gitStatusChild.stdout:split("\n")

    for lineCount, line in statusLines do
        if lineCount > 6 then
            local type, file = line:match("^%s(.+):   (.+)$")
            if type == nil then
                break
            end

            file = file:gsub("(%(.*%))", "") 

            table.insert(statusDiff, {type = type, file = file})
        end

        continue
    end

    local typeCounts = setmetatable({}, {
        __index = function(self, key)
            self[key] = setmetatable({}, {
                __index = function(self, key)
                    if rawget(self, key) == nil then
                        self[key] = 0
                    end
    
                    return rawget(self, key)
                end
            })

            return rawget(self, key)
        end
    })

    for _, diff in statusDiff do
        typeCounts[diff.type].count += 1
        table.insert(typeCounts[diff.type], diff.file)
    end
    
    print("Changes to commit:")
    for type, filesAndCount: {
        count: number,
        [number]: string,
    } in typeCounts do
        local count = filesAndCount.count
        local bullet = dim("•")
        stdio.write(`  {bullet} {
            stdio.color("yellow") .. stdio.style("bold") .. count .. stdio.style("reset")
        } files {type}`) 

        if count == 1 then
            stdio.write(` ({dim(filesAndCount[1]:gsub("%s", ""))})\n`)
            continue
        end

        stdio.write("\n")
        local files = filesAndCount
        files.count = nil
        for _, file in files do
            -- TODO: Map colors to type
            print(`    {bullet} {stdio.color("cyan") .. file:gsub("%s", "") .. stdio.color("reset")}`)
        end
    end

    print("Commit message:")
    -- TODO: Conventional commit prompts
    local commitMessage = stdio.prompt("text")
    local gitCommitChild = process.spawn("git", {"commit", "-a", "-m", commitMessage})
    if not gitCommitChild.ok then
        stdio.ewrite(gitCommitChild.stderr)
        return gitCommitChild.code
    end

    stdio.write("\n")
    local toPush = stdio.prompt("confirm", "Push changes to remote?")
    if toPush then
        local pushChild = process.spawn("lune", { "run", "$HOME/bin/gp.luau" }, {
            shell = true,
            stdio = "forward"
        })

        if not pushChild.ok then
            return pushChild.code
        end
    end

    return 0
end

return process.exit(main(process.args))