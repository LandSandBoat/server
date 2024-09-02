-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Sagittarius
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 112, 2, xi.regime.type.FIELDS)
end

return entity
