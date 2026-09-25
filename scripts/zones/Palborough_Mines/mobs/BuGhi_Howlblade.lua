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

entity.phList =
{
    [ID.mob.BU_GHI_HOWLBLADE - 1] = ID.mob.BU_GHI_HOWLBLADE, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 219)
end

return entity
