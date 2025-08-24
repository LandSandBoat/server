-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Daggerclaw Dracos
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DAGGERCLAW_DRACOS - 3] = ID.mob.DAGGERCLAW_DRACOS, -- 583.725 -15.652 -388.159
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 268)
    xi.regime.checkRegime(player, mob, 39, 1, xi.regime.type.FIELDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 365 })
end

return entity
