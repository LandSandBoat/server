-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Carnivorous Crawler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 23, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 24, 2, xi.regime.type.FIELDS)
end

return entity
