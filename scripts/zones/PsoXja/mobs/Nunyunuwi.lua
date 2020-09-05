-----------------------------------
-- Area: Pso'Xja
--  Mob: Nunyunuwi
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR and player:getCharVar("PromathiaStatus")==3) then
        player:setCharVar("PromathiaStatus", 4)
    end
end
