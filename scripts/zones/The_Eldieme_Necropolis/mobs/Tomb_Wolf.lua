-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Tomb Wolf
-- Note: PH for Cwn Cyrff
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
local entity = {}

local cwnCryffPHTable =
{
    [ID.mob.CWN_CYRFF - 4] = ID.mob.CWN_CYRFF, -- -375.862 0.542 382.17
    [ID.mob.CWN_CYRFF - 3] = ID.mob.CWN_CYRFF, -- -399.941 0.027 379.055
    [ID.mob.CWN_CYRFF - 2] = ID.mob.CWN_CYRFF, -- -384.019 0.509 384.26
    [ID.mob.CWN_CYRFF - 1] = ID.mob.CWN_CYRFF, -- -376.974 0.586 343.750
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 675, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, cwnCryffPHTable, 5, 3600) -- 1-4 hours
end

return entity
