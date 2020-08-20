-----------------------------------
-- Area: Batallia Downs
--  Mob: Suparna
-- Involved in Mission: San d'Orian 9-1
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 180)
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.BREAKING_BARRIERS and player:getCharVar("MissionStatus") == 3
        and GetMobByID(ID.mob.SUPARNA):isDead() and GetMobByID(ID.mob.SUPARNA_FLEDGLING):isDead()
    ) then
        player:setCharVar("Mission9-1Kills", 1)
    end
end
