-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Warlock
-- Note: PH for Viscount Morax
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

local viscountPHTable =
{
    [ID.mob.VISCOUNT_MORAX - 2] = ID.mob.VISCOUNT_MORAX, -- -365.684 -52.125 -136.540
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, viscountPHTable, 10, 3600) -- 1 hour
end

return entity
