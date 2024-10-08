-----------------------------------
-- Area: Uleguerand Range
--  Mob: Buffalo
-- Note: PH for Bonnacon
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

local bonnaconPHTable =
{
    [ID.mob.BONNACON - 6] = ID.mob.BONNACON, -- -623.154 -40.604 -51.621
    [ID.mob.BONNACON - 5] = ID.mob.BONNACON, -- -587.026 -40.994 -22.551
    [ID.mob.BONNACON - 4] = ID.mob.BONNACON, -- -513.416 -40.490 -43.706
    [ID.mob.BONNACON - 3] = ID.mob.BONNACON, -- -553.844 -38.958 -53.864
    [ID.mob.BONNACON - 2] = ID.mob.BONNACON, -- -631.268 -40.257 0.709
    [ID.mob.BONNACON - 1] = ID.mob.BONNACON, -- -513.999 -40.541 -34.928
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bonnaconPHTable, 5, math.random(3600, 86400)) -- 1 to 24 hours
end

return entity
