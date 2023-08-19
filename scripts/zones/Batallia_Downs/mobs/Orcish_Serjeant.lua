-----------------------------------
-- Area: Batallia Downs
--  Mob: Orcish Serjeant
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 74, 3, xi.regime.type.FIELDS)
end

return entity
