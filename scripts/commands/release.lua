-----------------------------------
-- func: release
-- desc: Releases the player from current events.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!release (name)')
end

commandObj.onTrigger = function(player, name)
    local target
    if name == nil then
        target = player
    else
        target = GetPlayerByName(name)
        if target == nil then
            error(player, string.format('Player named "%s" not found!', name))
            return
        end
    end

    target:release()
end

return commandObj
