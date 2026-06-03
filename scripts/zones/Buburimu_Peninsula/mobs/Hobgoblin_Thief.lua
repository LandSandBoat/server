-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Hobgoblin Thief
--  Job: THF
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.expeditionaryForce.onMobDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)
end

return entity
