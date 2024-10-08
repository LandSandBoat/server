-----------------------------------
-- Area: The Sanctuary of ZiTah
--   NM: Bastet
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 325)
end

return entity
