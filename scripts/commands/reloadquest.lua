-----------------------------------
-- func: reloadquest
-- desc: Attempt to reload specified quest lua without a restart.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 5,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!reloadquest <lua-file-name>')
end

local function fileExists(path)
    local f = io.open(path, 'r')
    return f ~= nil and io.close(f)
end

local folders =
{
    'sandoria',
    'bastok',
    'windurst',
    'jeuno',
    'otherAreas',
    'outlands',
    'ahtUrhgan',
    'hiddenQuests',
    'abyssea',
    'adoulin',
}

commandObj.onTrigger = function(player, questName)
    if questName == nil then
        error(player, 'Unable to reload quest.')
    end

    for _, area in ipairs(folders) do
        local filename = table.concat({ 'scripts/quests/', area, '/', questName })
        if fileExists(filename .. '.lua') then
            if package.loaded[filename] then
                local old = package.loaded[filename]
                package.loaded[filename] = nil
                if InteractionGlobal and old then
                    InteractionGlobal.lookup:removeContainer(old)
                end
            end

            local res = utils.prequire(filename)
            if InteractionGlobal and res then
                InteractionGlobal.lookup:addContainer(res)
                player:PrintToPlayer(string.format('Quest \'%s\' at \'%s\' has been reloaded.', questName, filename))
            end

            return
        end
    end

    error(player, string.format('Unable to find quest \'%s\' to reload.', questName))
end

return commandObj
