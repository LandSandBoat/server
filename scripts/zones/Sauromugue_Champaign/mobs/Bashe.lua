-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Bashe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 273)
    xi.magian.onMobDeath(mob, player, optParams, set{ 284 })
end

return entity
