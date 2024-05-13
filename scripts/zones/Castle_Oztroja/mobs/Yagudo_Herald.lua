-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Herald
-- Note: PH for Quu Domi the Gallant
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

local quuDomiPHTable =
{
    [ID.mob.QUU_DOMI_THE_GALLANT - 41] = ID.mob.QUU_DOMI_THE_GALLANT, -- 33.832 -0.068 -176.627
    [ID.mob.QUU_DOMI_THE_GALLANT - 33] = ID.mob.QUU_DOMI_THE_GALLANT, -- 18.545 -0.056 -120.283
    [ID.mob.QUU_DOMI_THE_GALLANT - 26] = ID.mob.QUU_DOMI_THE_GALLANT, -- 103.948 -1.250 -189.869
    [ID.mob.QUU_DOMI_THE_GALLANT - 3]  = ID.mob.QUU_DOMI_THE_GALLANT, -- 59.000 -4.000 -131.000
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, quuDomiPHTable, 5, 3600) -- 1 hour
end

return entity
