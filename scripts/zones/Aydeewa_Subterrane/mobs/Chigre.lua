-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Chigre
-----------------------------------
mixins = { require("scripts/mixins/rage") }
-----------------------------------
local entity = {}
-- Todo: add enailments, Drain samba on target if all ailments on, very fast enmity decay, capture speed

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
