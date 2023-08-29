-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Magmatic Eruca
-- Note: Place Holder Energetic Eruca
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
mixins = { require('scripts/mixins/families/eruca') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ENERGETIC_ERUCA_PH, 10, 86400) -- 24 hours
end

return entity
