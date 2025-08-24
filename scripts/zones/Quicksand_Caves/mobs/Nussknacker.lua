-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NUSSKNACKER - 7] = ID.mob.NUSSKNACKER, -- 189 2 4
    [ID.mob.NUSSKNACKER - 6] = ID.mob.NUSSKNACKER, -- 200 2 -4
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 4800)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
end

return entity
