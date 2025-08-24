-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Demonic Rose
-- Note: Placeholder V. Vivian
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = {}
    xi.mob.phOnDespawn(mob, ID.mob.VOLUPTUOUS_VIVIAN, 10, 57600, params) -- 16 hours
end

return entity
