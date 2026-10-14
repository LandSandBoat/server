-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Thread Leech
-- Note: PH for Bloodpool Vorax
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 22, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 23, 2, xi.regime.type.FIELDS)
end

return entity
