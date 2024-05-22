-----------------------------------
-- Area: Mount Zhayolm
--  Mob: Magmatic Eruca
-- Note: Place Holder Energetic Eruca
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
mixins = { require('scripts/mixins/families/eruca') }
-----------------------------------
local entity = {}

local erucaPHTable =
{
    -- TODO: This should be audited to make sure this is actually right
    [ID.mob.ENERGETIC_ERUCA - 320] = ID.mob.ENERGETIC_ERUCA, -- 175.315 -14.444 -173.589
    [ID.mob.ENERGETIC_ERUCA - 321] = ID.mob.ENERGETIC_ERUCA, -- 181.601 -14.120 -166.218
}
entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, erucaPHTable, 10, 86400) -- 24 hours
end

return entity
