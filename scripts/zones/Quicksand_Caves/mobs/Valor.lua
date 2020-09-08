-----------------------------------
-- Area: Quicksand Caves
--  Mob: Valor
-- Coming of Age (San dOria Mission 8-1)
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Quicksand_Caves/IDs")
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
    if (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.COMING_OF_AGE and player:getCharVar("MissionStatus") == 2
        and GetMobByID(ID.mob.VALOR):isDead() and GetMobByID(ID.mob.HONOR):isDead()
    ) then
        player:setCharVar("MissionStatus", 3)
    end
end
