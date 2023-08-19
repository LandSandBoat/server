-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Haunt
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 612, 2, xi.regime.type.GROUNDS)
end

return entity
