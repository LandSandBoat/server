-----------------------------------
-- func: garrison <command> (player)
-- commands:
-- !garrison start (player) starts the garrison for the given player (or targetted one). This bypasses requirements like lockout
-- !garrison stop  (player) stops the garrison (if any) currently running in the player's zone
-- !garrison win (player) win the garrison (if any) currently running in the player's zone
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    local usage = 'Usage: !garrison <command> (player)'
    player:PrintToPlayer(msg .. '\n' .. usage)
end

commandObj.onTrigger = function(player, command, target)
    -- Validate command
    if command == nil then
        error(player, 'Invalid command')
        return
    end

    -- Obtain target
    local targ = player:getCursorTarget()
    if target ~= nil then
        targ = GetPlayerByName(target)

        if targ == nil then
            error(player, string.format('Player named "%s" not found', target))
            return
        end
    else -- targ == nil, select player
        targ = player
    end

    -- Validate target
    if targ == nil and target == nil then
        error(player, 'Either provide a valid target name (in same zone) or target the desired player')
        return
    end

    local zone = targ:getZone()
    switch(command): caseof
    {
        ['start'] = function()
            xi.garrison.start(targ, targ)
            targ:PrintToPlayer(string.format('%s garrison started', zone:getName()))
        end,

        ['stop'] = function()
            xi.garrison.stop(targ:getZone())
            targ:PrintToPlayer(string.format('%s garrison stopped', zone:getName()))
        end,

        ['win'] = function()
            xi.garrison.win(targ:getZone())
        end,
    }
end

return commandObj
