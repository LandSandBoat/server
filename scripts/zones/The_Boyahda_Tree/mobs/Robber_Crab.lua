-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Robber Crab
-- Note: PH for Aquarius
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 720, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local params = {}
    xi.mob.phOnDespawn(mob, ID.mob.AQUARIUS, 20, 60 * 60, params) -- can repop in about an hour
end

return entity
