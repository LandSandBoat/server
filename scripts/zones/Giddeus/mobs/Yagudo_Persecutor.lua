-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Persecutor
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
local entity = {}

local juuDuzuPHTable =
{
    [ID.mob.JUU_DUZU_THE_WHIRLWIND + 233] = ID.mob.JUU_DUZU_THE_WHIRLWIND, -- 85.728 -0.071 -248.141
    [ID.mob.JUU_DUZU_THE_WHIRLWIND + 229] = ID.mob.JUU_DUZU_THE_WHIRLWIND, -- 72.302 0.642 -202.985
    [ID.mob.JUU_DUZU_THE_WHIRLWIND + 219] = ID.mob.JUU_DUZU_THE_WHIRLWIND, -- 20.353 -3.647 -169.309
    [ID.mob.JUU_DUZU_THE_WHIRLWIND + 225] = ID.mob.JUU_DUZU_THE_WHIRLWIND, -- 81.263 0.498 -208.812
    [ID.mob.JUU_DUZU_THE_WHIRLWIND - 9]   = ID.mob.JUU_DUZU_THE_WHIRLWIND, -- 99.902 -2.725 -213.337
    [ID.mob.JUU_DUZU_THE_WHIRLWIND - 2]   = ID.mob.JUU_DUZU_THE_WHIRLWIND, -- 116.667 -3.442 -261.079
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, juuDuzuPHTable, 5, 3600) -- 1 to 2 hours
end

return entity
