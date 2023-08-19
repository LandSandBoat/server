-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Demonic Weapon
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 102, 2, xi.regime.type.FIELDS)
end

return entity
