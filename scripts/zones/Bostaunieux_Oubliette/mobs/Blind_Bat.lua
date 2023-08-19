-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Blind Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 615, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 617, 2, xi.regime.type.GROUNDS)
end

return entity
