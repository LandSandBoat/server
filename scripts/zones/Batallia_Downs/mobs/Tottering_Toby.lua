-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Tottering Toby
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TOTTERING_TOBY - 27] = ID.mob.TOTTERING_TOBY, -- Confirmed on retail
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 161)
    xi.magian.onMobDeath(mob, player, optParams, set{ 151 })
end

return entity
