-----------------------------------
-- Area: Bibiki Bay
--  Mob: Coralline Uragnite
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.families.uragnite)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
