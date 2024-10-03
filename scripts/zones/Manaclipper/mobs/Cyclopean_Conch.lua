-----------------------------------
-- Area: Manaclipper
--   NM: Cyclopean Conch
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.families.uragnite)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('respawn', os.time() + 43200) -- 12 hour respawn
end

return entity
