-----------------------------------
-- Area: Caedarva Mire
--  Mob: Wild Karakul
-- Note: PH for Peallaidh
-----------------------------------
mixins = { require('scripts/mixins/families/chigoe_pet') }
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TMobEntity
local entity = {}

local peallaidhPHTable =
{
    [ID.mob.PEALLAIDH_PH_OFFSET]     = ID.mob.PEALLAIDH, -- 333.885 -9.646 -447.557
    [ID.mob.PEALLAIDH_PH_OFFSET + 1] = ID.mob.PEALLAIDH, -- 309.638 -8.548 -447.557
    [ID.mob.PEALLAIDH_PH_OFFSET + 2] = ID.mob.PEALLAIDH, -- 307.320 -10.088 -451.786
    [ID.mob.PEALLAIDH_PH_OFFSET + 3] = ID.mob.PEALLAIDH, -- 295.122 -12.271 -414.418
    [ID.mob.PEALLAIDH_PH_OFFSET + 4] = ID.mob.PEALLAIDH, -- 287.607 -16.220 -387.671
    [ID.mob.PEALLAIDH_PH_OFFSET + 5] = ID.mob.PEALLAIDH, -- 315.793 -16.336 -402.407
    [ID.mob.PEALLAIDH_PH_OFFSET + 6] = ID.mob.PEALLAIDH, -- 321.809 -16.843 -373.780
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, peallaidhPHTable, 5, 3600) -- 1 hour
end

return entity
