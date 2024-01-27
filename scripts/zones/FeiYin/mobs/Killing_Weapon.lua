-----------------------------------
-- Area: Fei'Yin
--  Mob: Killing Weapon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 716, 1, xi.regime.type.GROUNDS)
end

return entity
