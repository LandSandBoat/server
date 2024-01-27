-----------------------------------
-- Area: East Ronfaure [S]
--  Mob: Ladybug
-- Note: PH for Skogs Fru
-----------------------------------
local ID = zones[xi.zone.EAST_RONFAURE_S]
mixins = { require('scripts/mixins/families/ladybug') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SKOGS_FRU_PH, 5, 3600) -- 1 hour
end

return entity
