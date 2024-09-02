-----------------------------------
-- Area: Fei'Yin
--  Mob: Shadow
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 712, 1, xi.regime.type.GROUNDS)
end

return entity
