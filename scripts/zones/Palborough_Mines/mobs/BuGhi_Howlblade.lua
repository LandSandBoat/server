-----------------------------------
-- Area: Palborough Mines
--   NM: Bu'Ghi Howlblade
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.PALBOROUGH_MINES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  170.000, y = -15.000, z =  179.000 },
    { x =  170.000, y = -16.000, z =  165.000 },
    { x =  166.000, y = -16.000, z =  135.000 },
    { x =  167.207, y = -18.027, z =  159.374 },
    { x =  185.502, y = -31.864, z =  175.730 }
}

entity.phList =
{
    [ID.mob.BU_GHI_HOWLBLADE - 4] = ID.mob.BU_GHI_HOWLBLADE, -- 170.000 -15.000 179.000
    [ID.mob.BU_GHI_HOWLBLADE - 3] = ID.mob.BU_GHI_HOWLBLADE, -- 170.000 -16.000 165.000
    [ID.mob.BU_GHI_HOWLBLADE - 2] = ID.mob.BU_GHI_HOWLBLADE, -- 166.000 -16.000 135.000
    [ID.mob.BU_GHI_HOWLBLADE - 1] = ID.mob.BU_GHI_HOWLBLADE, -- 167.207 -18.027 159.374
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 219)
end

return entity
