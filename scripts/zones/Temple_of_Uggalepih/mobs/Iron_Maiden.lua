-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Iron Maiden
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 795, 2, xi.regime.type.GROUNDS)
end

return entity
