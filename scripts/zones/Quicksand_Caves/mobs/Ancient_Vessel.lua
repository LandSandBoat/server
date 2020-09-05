-----------------------------------
-- Area: Quicksand Caves
--  Mob: Ancient Vessel
-- Mithra and the Crystal (Zilart 12) Fight
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onMobDeath(mob, player, isKiller)

    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL and player:getCharVar("ZilartStatus") == 1) then
        player:needToZone(true)
        player:setCharVar("AncientVesselKilled", 1)
    end

end
