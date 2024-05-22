-----------------------------------
-- Area: Quicksand Caves
--  Mob: Helm Beetle
-- Note: PH for Diamond Daig
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
local entity = {}

local diamondPHTable =
{
    [ID.mob.DIAMOND_DAIG + 9] = ID.mob.DIAMOND_DAIG, -- -95.632 -0.5 -214.732
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 813, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, diamondPHTable, 10, 3600) -- 1 hour
end

return entity
