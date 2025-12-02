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
    xi.mob.phOnDespawn(mob, ID.mob.AQUARIUS, 5, 1, params) -- can repop instantly
end

return entity
