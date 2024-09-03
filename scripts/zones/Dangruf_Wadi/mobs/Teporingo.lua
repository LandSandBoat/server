-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 223)
    xi.magian.onMobDeath(mob, player, optParams, set{ 776 })
end

return entity
