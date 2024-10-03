-----------------------------------
-- Area: Manaclipper
--   NM: Zoredonite
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.applyMixins(mob, xi.mixins.job_special)
    xi.applyMixins(mob, xi.mixins.families.uragnite)
end

entity.onMobEngage = function(mob, player)
    mob:setLocalVar('[uragnite]inShellRegen', 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('respawn', os.time() + 43200) -- 12 hour respawn
end

return entity
