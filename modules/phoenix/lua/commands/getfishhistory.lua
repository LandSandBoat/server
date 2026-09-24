-----------------------------------
-- func: getfishhistory (player)
-- desc: Shows lifetime fishing records and the last 10 fish or items the cursor target or named player landed.
--       A named player does not need to be online.
-----------------------------------
-- luacheck: globals GetFishingRecords GetFishingHistory
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local historySize = 10

local units =
{
    { seconds = 86400, name = 'day'    },
    { seconds = 3600,  name = 'hour'   },
    { seconds = 60,    name = 'minute' },
    { seconds = 1,     name = 'second' },
}

local function report(player, msg)
    player:printToPlayer(msg, xi.msg.channel.SYSTEM_3)
end

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!getfishhistory (player)')
end

local function timeAgo(elapsed)
    for _, unit in ipairs(units) do
        if elapsed >= unit.seconds then
            local amount = math.floor(elapsed / unit.seconds)
            if amount == 1 then
                return string.format('1 %s ago', unit.name)
            end

            return string.format('%i %ss ago', amount, unit.name)
        end
    end

    return 'just now'
end

local function resolveName(player, name)
    if name ~= nil then
        return name
    end

    local cursorTarget = player:getCursorTarget()
    if
        cursorTarget ~= nil and
        cursorTarget:isPC()
    then
        return cursorTarget:getName()
    end

    return nil
end

commandObj.onTrigger = function(player, name)
    local targetName = resolveName(player, name)
    if targetName == nil then
        error(player, 'You must target a player or specify a name.')
        return
    end

    local records = GetFishingRecords(targetName)
    local history = GetFishingHistory(targetName, historySize)
    if records.linesCast == 0 and #history == 0 then
        report(player, string.format('No fishing history for "%s".', targetName))
        return
    end

    report(player, string.format('== %s: %i lines cast ==', targetName, records.linesCast))

    if records.longestIlms == 0 then
        report(player, 'Longest and heaviest: no big fish landed yet.')
    else
        report(player, string.format('Longest: %s, %i ilms', (records.longestName:gsub('_', ' ')), records.longestIlms))
        report(player, string.format('Heaviest: %s, %i ponzes', (records.heaviestName:gsub('_', ' ')), records.heaviestPonzes))
    end

    if #history == 0 then
        report(player, 'No catches in the last 30 days.')
        return
    end

    report(player, string.format('Last %i catches:', #history))

    local now = GetSystemTime()
    for _, entry in ipairs(history) do
        report(player, string.format('  %s: %i %s x%i (%s)',
            timeAgo(now - entry.caughtAt),
            entry.itemId,
            (entry.itemName:gsub('_', ' ')),
            entry.count,
            (entry.zoneName:gsub('_', ' '))))
    end
end

xi.module.registerCommand('getfishhistory', commandObj)
