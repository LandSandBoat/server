-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Ob
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
-- Todo: Pups can make it change frames, Overload causes Rage

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobDeath(mob, player, isKiller)
end
