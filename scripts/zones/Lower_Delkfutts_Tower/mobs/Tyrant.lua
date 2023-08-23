-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Tyrant
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 14)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 343)
end

return entity
