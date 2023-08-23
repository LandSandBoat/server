-----------------------------------
-- Area: FeiYin
--  Mob: Drone
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 711, 2, xi.regime.type.GROUNDS)
end

return entity
