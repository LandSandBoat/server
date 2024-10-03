-----------------------------------
-- Area: Dynamis - Tavnazia
--  Mob: Nightmare Taurus
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.dynamis_dreamland)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
