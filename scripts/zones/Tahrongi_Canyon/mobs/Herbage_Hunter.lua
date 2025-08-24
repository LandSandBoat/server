-----------------------------------
-- Area: Tahrongi Canyon
--   NM: Herbage Hunter
-----------------------------------
local ID = zones[xi.zone.TAHRONGI_CANYON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.HERBAGE_HUNTER - 1] = ID.mob.HERBAGE_HUNTER, -- -119.301, 24.087, 448.636
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 45)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 259)
    xi.magian.onMobDeath(mob, player, optParams, set{ 431 })
end

return entity
