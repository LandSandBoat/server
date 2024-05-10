-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Vorpal Bunny
-- Note: PH for Ratatoskr
-----------------------------------
local ID = zones[xi.zone.FORT_KARUGO_NARUGO_S]
-----------------------------------
local entity = {}

local ratatoskrPHTable =
{
    [ID.mob.RATATOSKR - 3] = ID.mob.RATATOSKR,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ratatoskrPHTable, 10, 5400) -- 90 minutes
end

return entity
