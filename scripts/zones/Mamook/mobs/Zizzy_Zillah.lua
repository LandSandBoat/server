-----------------------------------
-- Area: Mamook
--   NM: Zizzy Zillah
-----------------------------------
mixins = { require('scripts/mixins/families/ziz') }
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.ZIZZY_ZILLAH + 6]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 7]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 8]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 9]  = ID.mob.ZIZZY_ZILLAH,
    [ID.mob.ZIZZY_ZILLAH + 10] = ID.mob.ZIZZY_ZILLAH,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 460)
end

return entity
