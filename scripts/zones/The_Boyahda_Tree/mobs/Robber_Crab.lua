-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Robber Crab
-- Note: PH for Aquarius
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
local entity = {}

local aquariusPHTable =
{
    [ID.mob.AQUARIUS - 7] = ID.mob.AQUARIUS, -- 170.97 9.414 -12.579
    [ID.mob.AQUARIUS - 6] = ID.mob.AQUARIUS, -- 174.99 9.589 -16.718
    [ID.mob.AQUARIUS - 5] = ID.mob.AQUARIUS, -- 182.40 8.707 -33.993
    [ID.mob.AQUARIUS - 3] = ID.mob.AQUARIUS, -- 163.31 9.590 -58.550
    [ID.mob.AQUARIUS - 2] = ID.mob.AQUARIUS, -- 162.88 9.591 -58.082
    [ID.mob.AQUARIUS - 1] = ID.mob.AQUARIUS, -- 195.37 8.972 -73.536
    [ID.mob.AQUARIUS + 2] = ID.mob.AQUARIUS, -- 149.30 9.742 -64.239
    [ID.mob.AQUARIUS + 3] = ID.mob.AQUARIUS, -- 146.14 9.712 -51.616
    [ID.mob.AQUARIUS + 4] = ID.mob.AQUARIUS, -- 149.59 9.765 -61.490
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 720, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, aquariusPHTable, 5, 1) -- can repop instantly
end

return entity
