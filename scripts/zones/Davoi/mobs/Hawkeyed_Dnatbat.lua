-----------------------------------
-- Area: Davoi
--   NM: Hawkeyed Dnatbat
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 192)
    xi.magian.onMobDeath(mob, player, optParams, set{ 711 })
end

return entity
