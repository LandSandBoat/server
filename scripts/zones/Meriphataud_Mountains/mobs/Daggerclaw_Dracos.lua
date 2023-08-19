-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Daggerclaw Dracos
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 268)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
end

return entity
