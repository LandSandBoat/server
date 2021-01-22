-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Sabotender Enamorado
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES and player:getCharVar("MissionStatus") == 2 then
        player:setCharVar("Mission6-1MobKilled", 1)
    end
end

return entity
