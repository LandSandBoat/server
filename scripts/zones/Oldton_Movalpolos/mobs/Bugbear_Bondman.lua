-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Bugbear Bondman
-- Note: PH for Bugbear Strongman
-----------------------------------
local ID = zones[xi.zone.OLDTON_MOVALPOLOS]
-----------------------------------
local entity = {}

local bugbearPHTable =
{
    [ID.mob.BUGBEAR_STRONGMAN[1] - 2] = ID.mob.BUGBEAR_STRONGMAN[1], -- -81.31 31.493 210.675 (west)
    [ID.mob.BUGBEAR_STRONGMAN[2] - 1] = ID.mob.BUGBEAR_STRONGMAN[2], -- 58.013, 15.5, -121.928 (east)
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bugbearPHTable, 10, 1) -- no cooldown
end

return entity
