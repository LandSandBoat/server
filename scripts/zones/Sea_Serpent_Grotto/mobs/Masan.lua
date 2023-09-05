-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Masan
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1500)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1800)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 371)
end

return entity
