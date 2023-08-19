-----------------------------------
-- Area: Lufaise Meadows
--   NM: Megalobugard
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGEN, 25)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 439)
end

return entity
