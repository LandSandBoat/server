-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Lou Carcolh
-- Note: PH for Nommo
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local nommoPHTable =
{
    [ID.mob.NOMMO - 5] = ID.mob.NOMMO, -- -168.292 24.499 396.933
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, nommoPHTable, 10, 3600) -- 1 hour
end

return entity
