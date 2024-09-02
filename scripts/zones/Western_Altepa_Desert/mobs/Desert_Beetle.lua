-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 136, 1, xi.regime.type.FIELDS)
end

return entity
