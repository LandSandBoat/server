-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Gordov's Ghost
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    if player:getCurrentMission(BASTOK) == tpz.mission.id.bastok.ENTER_THE_TALEKEEPER and player:getCharVar("MissionStatus") == 2 then
        player:setCharVar("MissionStatus", 3)
    end
end

return entity
