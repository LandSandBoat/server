-----------------------------------
-- Area: Manaclipper
--   NM: Harajnite
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.families.uragnite)
end

entity.onMobEngage = function(mob, player)
    mob:setLocalVar('[uragnite]inShellRegen', 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
