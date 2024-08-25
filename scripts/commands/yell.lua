-----------------------------------
-- func: yell
-- desc: Bans a specified player from using /yell.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ssi'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!yell <ban/unban> (player) <days>')
end

commandObj.onTrigger = function(player, value, target, days)
    -- validate value
    if
        value ~= 'ban' and
        value ~= 'unban'
    then
        error(player, 'Parameter not specified <ban/unban>')
        return
    end

    -- validate target
    target = GetPlayerByName(target)
    if target == nil then
        error(player, 'Invalid target specified')
        return
    end

    if value == 'unban' then
        target:setCharVar('[YELL]Banned', 0)
        player:printToPlayer(string.format('%s has been unbanned from using the /yell command.', target:getName()))
    elseif value == 'ban' then
        -- validate duration
        if
            days == nil or
            days < 1
        then
            -- indefinite ban
            error(player, 'Invalid duration specified, defaulting to indefinite ban.')
            days = 0
        end

        target:setCharVar('[YELL]Banned', 1, os.time() + utils.days(days))
        player:printToPlayer(string.format('%s has been banned from using the /yell command.', target:getName()))
    end
end

return commandObj
