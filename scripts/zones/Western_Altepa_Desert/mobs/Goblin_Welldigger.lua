-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Goblin Welldigger
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 137, 1, xi.regime.type.FIELDS)
end

return entity
