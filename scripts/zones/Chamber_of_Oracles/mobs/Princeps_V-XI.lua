-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Princeps V-XI
-- Zilart 6 Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 280)
end

return entity
