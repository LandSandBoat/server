-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4800)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
end

return entity
