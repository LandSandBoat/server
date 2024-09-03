-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Goblin Reaper
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 113, 3, xi.regime.type.FIELDS)
end

return entity
