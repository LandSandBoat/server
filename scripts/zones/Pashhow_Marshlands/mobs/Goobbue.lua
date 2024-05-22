-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Goobbue
-- Note: PH for Jolly Green
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS]
-----------------------------------
local entity = {}

local jollyPHTable =
{
    [ID.mob.JOLLY_GREEN - 1] = ID.mob.JOLLY_GREEN, -- 184.993 24.499 -41.790
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 60, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, jollyPHTable, 5, 1) -- 1 second / no cooldown
end

return entity
