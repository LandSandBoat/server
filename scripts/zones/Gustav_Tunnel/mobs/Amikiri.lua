-----------------------------------
-- Area: Gustav Tunnel
--   NM: Amikiri
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 473)
end

return entity
