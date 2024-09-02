-----------------------------------
-- Area: Mamook
--  Mob: Ziz
-- Note: PH for Zizzy Zillah
-----------------------------------
mixins = { require('scripts/mixins/families/ziz') }
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

local zizzyPHTable =
{
    [ID.mob.ZIZZY_ZILLAH + 6]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 7]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 8]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 9]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 10] = ID.mob.ZIZZY_ZILLAH,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, zizzyPHTable, 5, 3600) -- 1 hour
end

return entity
