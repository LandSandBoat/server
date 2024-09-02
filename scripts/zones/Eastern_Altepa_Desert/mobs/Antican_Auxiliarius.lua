-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Auxiliarius
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 110, 1, xi.regime.type.FIELDS)
end

return entity
