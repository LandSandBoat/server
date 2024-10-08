-----------------------------------
-- Area: Den of Rancor
--  Mob: Demonic Pugil
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 801, 1, xi.regime.type.GROUNDS)
end

return entity
