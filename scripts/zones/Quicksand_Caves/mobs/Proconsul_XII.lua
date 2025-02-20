-----------------------------------
-- Area: Quicksand Caves
--   NM: Proconsul XII
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 9234)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 437)
end

return entity
