-----------------------------------
-- Area: Eastern Altepa Desert
--   NM: Donnergugi
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DONNERGUGI - 10] = ID.mob.DONNERGUGI,
    [ID.mob.DONNERGUGI - 5]  = ID.mob.DONNERGUGI,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 410)
end

return entity
