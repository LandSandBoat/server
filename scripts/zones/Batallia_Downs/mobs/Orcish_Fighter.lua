-----------------------------------
-- Area: Batallia Downs
--  Mob: Orcish Fighter
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 74, 3, xi.regime.type.FIELDS)
end

return entity
