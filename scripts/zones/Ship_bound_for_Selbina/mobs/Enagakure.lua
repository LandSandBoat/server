-----------------------------------
-- Area: Ship bound for Selbina
--  Mob: Enagakure
-- Involved in Quest: I'll Take the Big Box
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onMobDeath(mob, player, isKiller)

    if (player:hasKeyItem(tpz.ki.SEANCE_STAFF) and player:getCharVar("Enagakure_Killed") == 0) then
        player:setCharVar("Enagakure_Killed", 1)
    end

end
