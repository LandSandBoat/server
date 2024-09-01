-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Clipper
-- Note: PH for Cargo Crab Colin
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local colinPHTable =
{
    [ID.mob.CARGO_CRAB_COLIN + 22]  = ID.mob.CARGO_CRAB_COLIN, -- -30.384 1.000 -33.277
    [ID.mob.CARGO_CRAB_COLIN + 115] = ID.mob.CARGO_CRAB_COLIN, -- -85.000 -0.500 -37.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 731, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, colinPHTable, 5, 5400) -- 1 1/2 hr minimum
end

return entity
