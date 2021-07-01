-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Corrupted Soffeil
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(xi.mod.SLEEPRES, 50)
    mob:setMod(xi.mod.LULLABYRES, 50)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    if
        player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.RANPERRES_FINAL_REST and
        player:getMissionStatus(player:getNation()) == 1 and
        GetMobByID(ID.mob.CORRUPTED_YORGOS):isDead() and
        GetMobByID(ID.mob.CORRUPTED_ULBRIG):isDead()
    then
        player:setMissionStatus(player:getNation(), 2)
    end
end

return entity
