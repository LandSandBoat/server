-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 468)
end

return entity
