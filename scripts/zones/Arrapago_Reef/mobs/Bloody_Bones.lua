-----------------------------------
-- Area: Arrapago Reef
--   NM: Bloody Bones
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BLOODY_BONES - 2] = ID.mob.BLOODY_BONES, -- 136.234 -6.831 468.779
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 472)
end

return entity
