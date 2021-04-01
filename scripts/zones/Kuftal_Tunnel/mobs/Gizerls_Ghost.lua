-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Gizerl's Ghost
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(BASTOK) == xi.mission.id.bastok.ENTER_THE_TALEKEEPER and player:getCharVar("MissionStatus") == 2 then
        player:setCharVar("MissionStatus", 3)
    end
end

return entity
