-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 424)
end

return entity
