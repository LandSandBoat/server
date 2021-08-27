-----------------------------------
-- Area: Quicksand Caves
--  Mob: Ancient Vessel
-- Mithra and the Crystal (Zilart 12) Fight
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(ZILART) == xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL and player:getMissionStatus(xi.mission.log_id.ZILART) == 1 then
        player:needToZone(true)
        player:setCharVar("AncientVesselKilled", 1)
    end
end

return entity
