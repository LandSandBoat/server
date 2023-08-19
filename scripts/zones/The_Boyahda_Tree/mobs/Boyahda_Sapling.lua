-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Boyahda Sapling
-- Note: PH for Leshonki
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 725, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.LESHONKI_PH, 5, 3600) -- 1 hour
end

return entity
