-----------------------------------
-- Area: Valkurm Dunes (103)
--  Mob: Giant Bat
--  PH for Golden Bat
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
local entity = {}

local goldenBatPHTable =
{
    [ID.mob.GOLDEN_BAT - 3] = ID.mob.GOLDEN_BAT, -- -296.679 -0.510 -164.298
    [ID.mob.GOLDEN_BAT - 2] = ID.mob.GOLDEN_BAT, -- -804.502 -8.567 22.082
    [ID.mob.GOLDEN_BAT - 1] = ID.mob.GOLDEN_BAT, -- -798.674 -8.672 19.204
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, goldenBatPHTable, 5, 3600) -- 1 hour minimum
end

return entity
