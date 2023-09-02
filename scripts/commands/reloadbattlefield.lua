-----------------------------------
-- func: reloadbattlefield
-- desc: Attempt to reload specified battlefield lua without a restart.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!reloadbattlefield <lua-file-name>')
end

local function fileExists(path)
    local f = io.open(path, 'r')
    return f ~= nil and io.close(f)
end

commandObj.onTrigger = function(player, battlefieldName)
    if battlefieldName == nil then
        error(player, 'Unable to reload battlefield.')
        return
    end

    local content = xi.battlefield.contents[xi.battlefield.id[string.upper(battlefieldName)]]
    if content == nil then
        error(player, string.format('Unable to find battlefield \'%s\' to reload.', battlefieldName))
        return
    end

    local filename = content.filename
    if filename and fileExists(filename .. '.lua') then
        if package.loaded[filename] then
            local old = package.loaded[filename]
            package.loaded[filename] = nil
            if InteractionGlobal and old then
                InteractionGlobal.lookup:removeContainer(old)
            end
        end

        local container = utils.prequire(filename)
        container.filename = filename
        if InteractionGlobal and container then
            InteractionGlobal.lookup:addContainer(container)
            player:PrintToPlayer(string.format('Battlefield \'%s\' at \'%s\' has been reloaded.', battlefieldName, filename))
        end

        return
    end

    error(player, string.format('Unable to find battlefield \'%s\' to reload.', battlefieldName))
end

return commandObj
