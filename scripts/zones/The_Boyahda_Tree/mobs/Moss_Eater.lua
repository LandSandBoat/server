-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Moss Eater
-- Note: PH for Unut
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
local entity = {}

local unutPHTable =
{
    [ID.mob.UNUT - 15] = ID.mob.UNUT, -- 112.08 8.368 34.423
    [ID.mob.UNUT - 14] = ID.mob.UNUT, -- 134.44 7.846 45.197
    [ID.mob.UNUT - 13] = ID.mob.UNUT, -- 127.32 7.768 93.138
    [ID.mob.UNUT - 11] = ID.mob.UNUT, -- 95.055 8.132 71.958
    [ID.mob.UNUT - 10] = ID.mob.UNUT, -- 108.66 8.193 49.643
    [ID.mob.UNUT - 9]  = ID.mob.UNUT, -- 97.774 7.837 67.815
    [ID.mob.UNUT - 4]  = ID.mob.UNUT, -- 109.55 8.561 83.275
    [ID.mob.UNUT - 3]  = ID.mob.UNUT, -- 59.283 8.700 78.246
    [ID.mob.UNUT - 2]  = ID.mob.UNUT, -- 60.408 8.711 82.500
    [ID.mob.UNUT + 1]  = ID.mob.UNUT, -- 70.822 6.211 61.711
    [ID.mob.UNUT + 2]  = ID.mob.UNUT, -- 57.942 8.544 88.215
    [ID.mob.UNUT + 3]  = ID.mob.UNUT, -- 66.392 5.884 66.909
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 721, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, unutPHTable, 5, 7200) -- 2 hours
end

return entity
