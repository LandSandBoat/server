-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Raptor
-- Note: PH for Daggerclaw Dracos
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
---@type TMobEntity
local entity = {}

local daggerclawPHTable =
{
    [ID.mob.DAGGERCLAW_DRACOS - 3] = ID.mob.DAGGERCLAW_DRACOS, -- 583.725 -15.652 -388.159
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, daggerclawPHTable, 10, 3600) -- 1 hour
end

return entity
