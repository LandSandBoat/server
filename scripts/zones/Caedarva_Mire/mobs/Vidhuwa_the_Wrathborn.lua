-----------------------------------
-- Area: Caedarva Mire
--   NM: Vidhuwa the Wrathborn
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 471)
end

return entity
