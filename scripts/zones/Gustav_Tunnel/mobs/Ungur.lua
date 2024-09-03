-----------------------------------
-- Area: Gustav Tunnel
--   NM: Ungur
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 475)
end

return entity
