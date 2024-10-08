-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Hoarder Hare
-- Note: PH for Teporingo
-----------------------------------
local ID = zones[xi.zone.DANGRUF_WADI]
-----------------------------------
---@type TMobEntity
local entity = {}

local teporingoPHTable =
{
    [ID.mob.TEPORINGO - 1] = ID.mob.TEPORINGO,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, teporingoPHTable, 20, 3600) -- 1 hour
end

return entity
