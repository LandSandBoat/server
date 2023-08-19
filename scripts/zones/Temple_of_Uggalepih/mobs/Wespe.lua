-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Wespe
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 790, 2, xi.regime.type.GROUNDS)
end

return entity
