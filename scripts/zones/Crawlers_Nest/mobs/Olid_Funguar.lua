-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Olid Funguar
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 694, 2, xi.regime.type.GROUNDS)
end

return entity
