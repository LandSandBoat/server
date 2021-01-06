-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Nio-Hum
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 180)
    mob:addMod(tpz.mod.SLEEPRES, 50)
    mob:addMod(tpz.mod.LULLABYRES, 50)
    mob:addMod(tpz.mod.STUNRES, 50)
    mob:addMod(tpz.mod.DMGMAGIC, 80)
end

function onMobDeath(mob, player, isKiller)
    if
        player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.LIGHTBRINGER and
        player:getCharVar("MissionStatus") == 5 and
        GetMobByID(ID.mob.NIO_A):isDead()
    then
        player:setCharVar("Mission8-2Kills", 1)
    end
end

return entity
