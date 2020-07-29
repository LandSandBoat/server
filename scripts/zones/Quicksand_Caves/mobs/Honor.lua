-----------------------------------
-- Area: Quicksand Caves
--  Mob: Honor
-- Coming of Age (San dOria Mission 8-1)
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 180)
    mob:addMod(tpz.mod.SLEEPRES, 50)
    mob:addMod(tpz.mod.LULLABYRES, 50)
end

function onMobDeath(mob, player, isKiller)
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.COMING_OF_AGE and player:getCharVar("MissionStatus") == 2) then
        player:setCharVar("MissionStatus", 3)
    end
end
