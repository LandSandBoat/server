-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Ratatoskr
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 522)
    xi.magian.onMobDeath(mob, player, optParams, set{ 155, 369, 583 })
end

return entity
