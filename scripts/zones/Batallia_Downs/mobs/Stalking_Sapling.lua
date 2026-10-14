-----------------------------------
-- Area: Batallia Downs
--  Mob: Stalking Sapling
-- Note: PH for Tottering Toby
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 72, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 73, 1, xi.regime.type.FIELDS)
end

return entity
