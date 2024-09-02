-----------------------------------
-- Area: Gustav Tunnel
--   NM: Goblinsavior Heronox
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 423)
end

return entity
