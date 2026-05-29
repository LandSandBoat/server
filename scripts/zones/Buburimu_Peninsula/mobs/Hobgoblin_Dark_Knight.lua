-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Hobgoblin Dark Knight
--  Job: DRK
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.expeditionaryForce.onMobDeath(mob)
end

entity.onMobDespawn = function(mob)
    xi.expeditionaryForce.onMobDespawn(mob)
end

return entity
