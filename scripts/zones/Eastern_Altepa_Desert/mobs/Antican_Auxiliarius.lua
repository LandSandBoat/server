-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Auxiliarius
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 110, 1, xi.regime.type.FIELDS)
end

return entity
