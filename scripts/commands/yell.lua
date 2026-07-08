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
    local targ
    if target == nil then
        error(player, 'You must enter a target player name.')
        return
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    if value == 'unban' then
        targ:setCharVar('[YELL]Banned', 0)
        player:printToPlayer(string.format('%s has been unbanned from using the /yell command.', targ:getName()))
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

        targ:setCharVar('[YELL]Banned', 1, GetSystemTime() + utils.days(days))
        player:printToPlayer(string.format('%s has been banned from using the /yell command.', targ:getName()))
    end
end

return commandObj
