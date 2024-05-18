-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Mendicant
-----------------------------------
local ID = zones[xi.zone.GIDDEUS]
-----------------------------------
local entity = {}

local hooMjuuPHTable =
{
    [ID.mob.HOO_MJUU_THE_TORRENT - 2] = ID.mob.HOO_MJUU_THE_TORRENT, -- -39.073 0.597 -115.279
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hooMjuuPHTable, 12, 3600) -- 1 hour
end

return entity
