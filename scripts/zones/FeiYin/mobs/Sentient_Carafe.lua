-----------------------------------
-- Area: Fei'Yin
--  Mob: Sentient Carafe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 718, 2, xi.regime.type.GROUNDS)
end

return entity
