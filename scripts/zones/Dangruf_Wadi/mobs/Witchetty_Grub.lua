-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Witchetty Grub
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 643, 1, xi.regime.type.GROUNDS)
end

return entity
