-----------------------------------
-- func: addallmounts
-- desc: Adds all mount key items to player, granting access to their associated mounts
-----------------------------------
require("scripts/globals/keyitems")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!addallmounts (player)")
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

    -- add all mount key items
    for i = xi.ki.CHOCOBO_COMPANION, xi.ki.CHOCOBO_COMPANION + 26 do
        targ:addKeyItem(i)
    end

    player:PrintToPlayer(string.format("%s now has all mounts.", targ:getName()))
end
