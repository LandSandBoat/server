-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Tiny Lycopodium
-- Note: PH for Jeduah
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA_S]
mixins = { require('scripts/mixins/families/lycopodium') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.JEDUAH, 10, 3600) -- 1 hour
end

return entity
