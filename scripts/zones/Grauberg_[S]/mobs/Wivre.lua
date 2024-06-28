-----------------------------------
-- Area: Grauberg [S]
--  Mob: Wivre
-- Note: PH for Vasiliceratops
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
local entity = {}

local vasiliceratopsPHTable =
{
    [ID.mob.VASILICERATOPS - 3] = ID.mob.VASILICERATOPS,
    -- [ID.mob.VASILICERATOPS - 67] = ID.mob.VASILICERATOPS,
    -- TODO: Add shared spawning for the PH. Only one PH is alive at a time. Spawns in either spot.
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, vasiliceratopsPHTable, 10, 5400) -- 1.5 hour
end

return entity
