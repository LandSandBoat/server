-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Corrupted Yorgos
-----------------------------------
local ID = require("scripts/zones/King_Ranperres_Tomb/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(tpz.mod.SLEEPRES, 50)
    mob:setMod(tpz.mod.LULLABYRES, 50)
end

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 180)
end

function onMobDeath(mob, player, isKiller)
    if
        player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST and
        player:getCharVar("MissionStatus") == 1 and
        GetMobByID(ID.mob.CORRUPTED_SOFFEIL):isDead() and
        GetMobByID(ID.mob.CORRUPTED_ULBRIG):isDead()
    then
        player:setCharVar("MissionStatus", 2)
    end
end
