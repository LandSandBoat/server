-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Faber
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 110, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 111, 2, xi.regime.type.FIELDS)
end

return entity
