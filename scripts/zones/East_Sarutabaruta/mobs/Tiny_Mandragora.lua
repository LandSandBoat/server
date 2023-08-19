-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Tiny Mandragora
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 89, 1, xi.regime.type.FIELDS)
end

return entity
