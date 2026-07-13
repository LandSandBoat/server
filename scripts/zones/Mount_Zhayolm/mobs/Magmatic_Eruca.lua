-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Magmatic Eruca
-- Note: Place Holder Energetic Eruca
-----------------------------------
mixins =
{
    require('scripts/mixins/families/eruca'),
    require('scripts/mixins/sleep_at_night'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, zones[xi.zone.MOUNT_ZHAYOLM].mob.ENERGETIC_ERUCA, 10, 86400, params) -- 24 hours
end

return entity
