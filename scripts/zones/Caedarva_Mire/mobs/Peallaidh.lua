-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
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
    xi.hunts.checkHunt(mob, player, 468)
end

return entity
