-----------------------------------
-- Area: Palborough Mines
--  Mob: Copper Beetle
-- Note: PH for Bu'Ghi Howlblade
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
local entity = {}

local buGhiHowlbladePHTable =
{
    [ID.mob.BU_GHI_HOWLBLADE - 4] = ID.mob.BU_GHI_HOWLBLADE, -- 170.000 -15.000 179.000
    [ID.mob.BU_GHI_HOWLBLADE - 3] = ID.mob.BU_GHI_HOWLBLADE, -- 170.000 -16.000 165.000
    [ID.mob.BU_GHI_HOWLBLADE - 2] = ID.mob.BU_GHI_HOWLBLADE, -- 166.000 -16.000 135.000
    [ID.mob.BU_GHI_HOWLBLADE - 1] = ID.mob.BU_GHI_HOWLBLADE, -- 167.207 -18.027 159.374
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, buGhiHowlbladePHTable, 10, 3600) -- 1 hour
end

return entity
