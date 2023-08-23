-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Bakru
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 26, 1, xi.regime.type.FIELDS)
end

return entity
