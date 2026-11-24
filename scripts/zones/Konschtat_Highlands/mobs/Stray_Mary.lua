-----------------------------------
-- Area: Konschtat Highlands
--   NM: Stray Mary
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if player then
        xi.hunts.checkHunt(mob, player, 203)
        xi.magian.onMobDeath(mob, player, optParams, set{ 710 })
    end
end

return entity
