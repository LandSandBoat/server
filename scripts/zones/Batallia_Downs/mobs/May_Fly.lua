-----------------------------------
-- Area: Batallia Downs
--  Mob: May Fly
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 15, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 72, 2, xi.regime.type.FIELDS)
end

return entity
