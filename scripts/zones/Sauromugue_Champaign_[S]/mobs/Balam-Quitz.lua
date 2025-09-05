-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Balam-Quitz
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  446.853, y =  23.817, z =  72.982 }
}

entity.phList =
{
    [ID.mob.BALAM_QUITZ - 5] = ID.mob.BALAM_QUITZ, -- 481.509 24.184 98.264
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 529)
end

return entity
