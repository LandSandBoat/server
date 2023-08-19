-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Trembler Tabitha
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 293)
end

return entity
