-----------------------------------
-- Area: Arrapago Reef
--  Mob: Draugar Servant
-- Note: PH for Bloody Bones
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
---@type TMobEntity
local entity = {}

local bloodyBonesPHTable =
{
    [ID.mob.BLOODY_BONES - 2] = ID.mob.BLOODY_BONES, -- 136.234 -6.831 468.779
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bloodyBonesPHTable, 5, 75600) -- 21 hours
end

return entity
