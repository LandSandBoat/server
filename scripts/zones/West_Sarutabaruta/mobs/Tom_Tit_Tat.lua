-----------------------------------
-- Area: West Sarutabaruta
--   NM: Tom Tit Tat
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TOM_TIT_TAT - 2] = ID.mob.TOM_TIT_TAT, -- 77.509 -20.719 434.757
    [ID.mob.TOM_TIT_TAT - 1] = ID.mob.TOM_TIT_TAT, -- 31.149 -20.045 358.265
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 250)
end

return entity
