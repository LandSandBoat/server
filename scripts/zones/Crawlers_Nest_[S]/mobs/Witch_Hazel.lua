-----------------------------------
-- Area: Crawlers' Nest [S]
--  Mob: Witch Hazel
-- Note: PH for Morille Mortelle
-----------------------------------
local ID = zones[xi.zone.CRAWLERS_NEST_S]
-----------------------------------
local entity = {}

local morillePHTable =
{
    [ID.mob.MORILLE_MORTELLE - 4] = ID.mob.MORILLE_MORTELLE, -- 61 0 -4
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, morillePHTable, 12, 18000) -- 5 hours
end

return entity
