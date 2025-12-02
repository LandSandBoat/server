-----------------------------------
-- Area: Konschtat Highlands
--   NM: Tremor Ram
-- Note: PH for Rampaging Ram
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.RAMPAGING_RAM, 10, 1200) -- 20 min
end

return entity
