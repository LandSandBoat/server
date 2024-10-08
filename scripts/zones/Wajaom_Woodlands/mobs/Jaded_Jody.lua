-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Jaded Jody
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 448)
end

return entity
