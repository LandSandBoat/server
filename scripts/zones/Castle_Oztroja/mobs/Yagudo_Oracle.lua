-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Oracle
-- Note: PH for Quu Domi the Gallant
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

local quuDomiPHTable =
{
    [ID.mob.QUU_DOMI_THE_GALLANT - 39] = ID.mob.QUU_DOMI_THE_GALLANT, -- 46.861 0.343 -176.989
    [ID.mob.QUU_DOMI_THE_GALLANT - 25] = ID.mob.QUU_DOMI_THE_GALLANT, -- 67.103 -0.079 -176.981
    [ID.mob.QUU_DOMI_THE_GALLANT - 17] = ID.mob.QUU_DOMI_THE_GALLANT, -- 99.000 -0.181 -149.000
    [ID.mob.QUU_DOMI_THE_GALLANT - 2]  = ID.mob.QUU_DOMI_THE_GALLANT, -- 35.847 -0.500 -101.685
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, quuDomiPHTable, 5, 3600) -- 1 hour
end

return entity
