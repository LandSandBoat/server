-----------------------------------
-- Area: Quicksand Caves
--   NM: Hastatus XI-XII
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.HASTATUS_XI_XII - 4] = ID.mob.HASTATUS_XI_XII, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 650)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1450)
end

return entity
