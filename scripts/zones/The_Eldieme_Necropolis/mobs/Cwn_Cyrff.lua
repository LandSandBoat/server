-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Cwn Cyrff
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -395.612, y = -0.102, z =  378.777 }
}

entity.phList =
{
    [ID.mob.CWN_CYRFF - 4] = ID.mob.CWN_CYRFF, -- -375.862 0.542 382.17
    [ID.mob.CWN_CYRFF - 3] = ID.mob.CWN_CYRFF, -- -399.941 0.027 379.055
    [ID.mob.CWN_CYRFF - 2] = ID.mob.CWN_CYRFF, -- -384.019 0.509 384.26
    [ID.mob.CWN_CYRFF - 1] = ID.mob.CWN_CYRFF, -- -376.974 0.586 343.750
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 191)
end

return entity
