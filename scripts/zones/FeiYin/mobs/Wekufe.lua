-----------------------------------
-- Area: Fei'Yin
--  Mob: Wekufe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 717, 2, xi.regime.type.GROUNDS)
end

return entity
