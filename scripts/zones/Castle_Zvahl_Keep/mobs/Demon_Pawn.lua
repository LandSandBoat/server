-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Pawn
-- Note: PH for Baronet Romwe
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

local baronetPHTable =
{
    [ID.mob.BARONET_ROMWE - 2] = ID.mob.BARONET_ROMWE, -- -317.070 -52.125 14.052
    [ID.mob.BARONET_ROMWE - 1] = ID.mob.BARONET_ROMWE, -- -335.444 -52.125 15.148
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, baronetPHTable, 10, 3600) -- 1 hour
end

return entity
