-----------------------------------
-- Area: Fort Ghelsba
--  Mob: Orcish Fodder
-- Note: PH for Hundredscar Hajwaj
-----------------------------------
local ID = zones[xi.zone.FORT_GHELSBA]
-----------------------------------
---@type TMobEntity
local entity = {}

local hundredscarPHTable =
{
    [ID.mob.HUNDREDSCAR_HAJWAJ - 5] = ID.mob.HUNDREDSCAR_HAJWAJ,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, hundredscarPHTable, 10, 3600) -- 1 hour
end

return entity
