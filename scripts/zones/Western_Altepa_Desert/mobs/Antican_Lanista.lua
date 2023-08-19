-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Antican Lanista
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 138, 2, xi.regime.type.FIELDS)
end

return entity
