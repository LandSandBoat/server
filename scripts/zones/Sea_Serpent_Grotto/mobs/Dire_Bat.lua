-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Dire Bat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 809, 2, xi.regime.type.GROUNDS)
end

return entity
