-----------------------------------
-- Area: Fei'Yin
--  Mob: Shadow
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 712, 1, xi.regime.type.GROUNDS)
end

return entity
