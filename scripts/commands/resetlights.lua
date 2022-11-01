---------------------------------------------------------------------------------------------------
-- func: resetlights
-- desc: resets all lights to 0
---------------------------------------------------------------------------------------------------
require("scripts/globals/abyssea")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!resetlights (player)")
end

function onTrigger(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    xi.abyssea.resetPlayerLights(targ)
    player:PrintToPlayer(string.format("%s's lights have been reset!. ", targ:getName()))
end
