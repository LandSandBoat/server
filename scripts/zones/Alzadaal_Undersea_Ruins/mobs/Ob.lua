-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Ob
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- Todo: Pups can make it change frames, Overload causes Rage

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
