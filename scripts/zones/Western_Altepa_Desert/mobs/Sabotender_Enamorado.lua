-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Sabotender Enamorado
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.LEAUTES_LAST_WISHES and player:getMissionStatus(player:getNation()) == 2 then
        player:setCharVar("Mission6-1MobKilled", 1)
    end
end

return entity
