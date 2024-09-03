-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Greatclaw
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 811, 2, xi.regime.type.GROUNDS)
end

return entity
