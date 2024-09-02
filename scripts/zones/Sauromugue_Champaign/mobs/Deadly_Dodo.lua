-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Deadly Dodo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 272)
    xi.magian.onMobDeath(mob, player, optParams, set{ 580 })
end

return entity
