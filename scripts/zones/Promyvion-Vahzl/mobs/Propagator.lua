-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Propagator
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 1 then
        player:setCharVar("PromathiaStatus", 2)
    end
end
