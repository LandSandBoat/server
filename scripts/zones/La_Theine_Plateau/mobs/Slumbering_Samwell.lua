-----------------------------------
-- Area: La Theine Plateau
--   NM: Slumbering Samwell
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 155)
end

return entity
