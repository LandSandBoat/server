-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Strongman
-----------------------------------
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BUGBEAR_STRONGMAN[1] - 2] = ID.mob.BUGBEAR_STRONGMAN[1], -- -81.31 31.493 210.675 (west)
    [ID.mob.BUGBEAR_STRONGMAN[2] - 1] = ID.mob.BUGBEAR_STRONGMAN[2], -- 58.013, 15.5, -121.928 (east)
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 244)
    xi.magian.onMobDeath(mob, player, optParams, set{ 5, 515, 894 })
end

return entity
