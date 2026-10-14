-----------------------------------
-- Area: Xarcabard
--  Mob: Cursed Weapon
-- Note: PH for Barbaric Weapon
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 52, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 53, 3, xi.regime.type.FIELDS)
end

return entity
