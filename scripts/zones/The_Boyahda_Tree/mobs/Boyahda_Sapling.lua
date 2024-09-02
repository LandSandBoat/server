-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Boyahda Sapling
-- Note: PH for Leshonki
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

local leshonkiPHTable =
{
    [ID.mob.LESHONKI - 7] = ID.mob.LESHONKI, -- -222.0 14.380 25.724
    [ID.mob.LESHONKI - 6] = ID.mob.LESHONKI, -- -223.5 14.430 23.877
    [ID.mob.LESHONKI - 5] = ID.mob.LESHONKI, -- -215.2 13.585 68.666
    [ID.mob.LESHONKI - 4] = ID.mob.LESHONKI, -- -216.4 14.317 56.532
    [ID.mob.LESHONKI + 2] = ID.mob.LESHONKI, -- -223.8 14.267 96.920
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 725, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, leshonkiPHTable, 5, 3600) -- 1 hour
end

return entity
