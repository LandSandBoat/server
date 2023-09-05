-----------------------------------
-- Area: Batallia Downs [S]
--   NM: Habergoass
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 75)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 493)
end

return entity
