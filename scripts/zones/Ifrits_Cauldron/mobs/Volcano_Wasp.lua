-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Volcano Wasp
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 755, 1, xi.regime.type.GROUNDS)
end

return entity
