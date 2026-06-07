-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Hobgoblin Black Mage
--  Job: BLM
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minute idle despawn
end

entity.onMobDeath = function(mob, player, optParams)
    xi.expeditionaryForce.onMobDeath(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)
end

return entity