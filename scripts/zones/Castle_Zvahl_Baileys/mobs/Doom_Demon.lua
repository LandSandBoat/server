-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Doom Demon
-- Note: PH for Marquis Sabnock
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TMobEntity
local entity = {}

local marquisPHTable =
{
    [ID.mob.MARQUIS_SABNOCK + 1] = ID.mob.MARQUIS_SABNOCK,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, marquisPHTable, 10, 7200) -- 2 hour
end

return entity
