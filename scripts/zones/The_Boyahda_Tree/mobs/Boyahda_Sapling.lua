-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Boyahda Sapling
-- Note: PH for Leshonki
-- TODO: 3 PHs should be in a spawning group that only one of them can be up at a time
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 725, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.dayOnly = true
    xi.mob.phOnDespawn(mob, ID.mob.LESHONKI, 5, 3600, params) -- 1 hour
end

return entity
