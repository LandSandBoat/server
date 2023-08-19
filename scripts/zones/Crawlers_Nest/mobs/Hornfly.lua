-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Hornfly
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 690, 2, xi.regime.type.GROUNDS)
end

return entity
