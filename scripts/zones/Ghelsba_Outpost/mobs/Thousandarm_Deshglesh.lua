-----------------------------------
-- Area: Ghelsba Outpost (140)
--   NM: Thousandarm Deshglesh
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.GHELSBA_OUTPOST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.THOUSANDARM_DESHGLESH - 3] = ID.mob.THOUSANDARM_DESHGLESH, -- Confirmed on retail
    [ID.mob.THOUSANDARM_DESHGLESH - 2] = ID.mob.THOUSANDARM_DESHGLESH, -- Confirmed on retail
    [ID.mob.THOUSANDARM_DESHGLESH - 1] = ID.mob.THOUSANDARM_DESHGLESH, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 170)
end

return entity
