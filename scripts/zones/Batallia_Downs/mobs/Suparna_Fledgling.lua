-----------------------------------
-- Area: Batallia Downs
--  Mob: Suparna Fledgling
-- Involved in Mission: San d'Orian 9-1
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(SANDORIA) == xi.mission.id.sandoria.BREAKING_BARRIERS and player:getMissionStatus(player:getNation()) == 3
        and GetMobByID(ID.mob.SUPARNA):isDead() and GetMobByID(ID.mob.SUPARNA_FLEDGLING):isDead()
    ) then
        player:setCharVar("Mission9-1Kills", 1)
    end
end

return entity
