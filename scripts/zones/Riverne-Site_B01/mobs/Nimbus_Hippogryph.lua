-----------------------------------
-- Area: Riverne - Site B01
--  Mob: Nimbus Hippogryph
-- Note: Place holder Imdugud
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

local imdugudPHTable =
{
    [ID.mob.IMDUGUD - 6] = ID.mob.IMDUGUD, -- 650.770 20.052 676.513
    [ID.mob.IMDUGUD - 5] = ID.mob.IMDUGUD, -- 643.308 20.049 652.354
    [ID.mob.IMDUGUD - 4] = ID.mob.IMDUGUD, -- 669.574 19.215 623.129
    [ID.mob.IMDUGUD - 3] = ID.mob.IMDUGUD, -- 691.504 21.296 583.884
    [ID.mob.IMDUGUD - 2] = ID.mob.IMDUGUD, -- 687.199 21.161 582.560
    [ID.mob.IMDUGUD - 1] = ID.mob.IMDUGUD, -- 666.737 20.012 652.352
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, imdugudPHTable, 10, 75600) -- 21 hours
end

return entity
