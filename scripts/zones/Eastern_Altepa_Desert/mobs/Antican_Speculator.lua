-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Speculator
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 112, 3, xi.regime.type.FIELDS)
end

return entity
