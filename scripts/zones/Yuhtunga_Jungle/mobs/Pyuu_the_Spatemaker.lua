-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Pyuu the Spatemaker
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 364)
    xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
end

return entity
