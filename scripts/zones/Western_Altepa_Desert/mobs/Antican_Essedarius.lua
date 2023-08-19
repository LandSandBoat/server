-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Essedarius
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 134, 2, xi.regime.type.FIELDS)
end

return entity
