-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Hippogryph
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.dynamis_dreamland)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('dynamis_currency', 1452)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
