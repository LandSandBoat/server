-----------------------------------
-- Area: Misareaux Coast
--  Mob: Warder Euphrosyne
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(COP) == tpz.mission.id.cop.A_PLACE_TO_RETURN and player:getCharVar("PromathiaStatus") == 1) then
        player:setCharVar("Warder_Euphrosyne_KILL", 1)
    end
end
