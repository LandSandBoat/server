-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Magmatic Eruca
-- Note: Place Holder Energetic Eruca
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
mixins = { require('scripts/mixins/families/eruca') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.ENERGETIC_ERUCA, 10, 86400, params) -- 24 hours
end

return entity
