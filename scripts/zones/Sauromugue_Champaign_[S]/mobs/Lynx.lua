-----------------------------------
-- Area: Sauromugue Champaign [S]
--  Mob: Lynx
-- Note: PH for Balam-Quitz
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local balamPHTable =
{
    [ID.mob.BALAM_QUITZ - 5] = ID.mob.BALAM_QUITZ, -- 481.509 24.184 98.264
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, balamPHTable, 10, 3600) -- 1 hour
end

return entity
