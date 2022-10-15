-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Lil Apkallu
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
-----------------------------------
local entity = {}
-- Todo: Apkallu hate, Hundred Fists, Movement and TP pattern

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
