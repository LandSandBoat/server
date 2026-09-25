-----------------------------------
-- Area: Qufim Island
--   NM: Trickster Kinetix
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TRICKSTER_KINETIX - 1] = ID.mob.TRICKSTER_KINETIX, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 307)
end

return entity
