-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Gargantua
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.GARGANTUA - 1] = ID.mob.GARGANTUA, -- 339 -0.472 -20
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 312)
    xi.magian.onMobDeath(mob, player, optParams, set{ 153, 367, 581 })
end

return entity
