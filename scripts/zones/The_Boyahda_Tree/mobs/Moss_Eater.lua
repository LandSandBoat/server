-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Moss Eater
-- Note: PH for Unut
-- TODO: 3 PHs should be in a spawning group that only one of them can be up at a time
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 721, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    xi.mob.phOnDespawn(mob, ID.mob.UNUT, 5, 7200, params) -- 2 hours
end

return entity
