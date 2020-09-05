-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM: Cheese Hoarder Gigiroon
-- TODO: Running around mechanic and dropping bombs
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobFight(mob, target)
end

function onMobDeath(mob)
end
