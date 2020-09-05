-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Yum Kimil
-- Involved in Quest: The Requiem (BARD AF2)
-- !pos -414 8 499 195
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if (player:getCharVar("TheRequiemCS") == 3) then
        player:setCharVar("TheRequiemYumKilled", 1)
    end
end
