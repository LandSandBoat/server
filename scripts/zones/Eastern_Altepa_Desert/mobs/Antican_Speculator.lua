-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Antican Speculator
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 112, 3, xi.regime.type.FIELDS)
end

return entity
