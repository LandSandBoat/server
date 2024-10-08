-----------------------------------
-- Area: Ranguemont Pass
--   NM: Hyakume
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 344)
    xi.magian.onMobDeath(mob, player, optParams, set{ 778 })
end

return entity
