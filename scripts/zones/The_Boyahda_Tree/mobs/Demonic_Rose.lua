-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Demonic Rose
-- Note: Placeholder V. Vivian
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
local entity = {}

local vivianPHTable =
{
    [ID.mob.VOLUPTUOUS_VIVIAN - 1] = ID.mob.VOLUPTUOUS_VIVIAN, -- -196.178 5.592 190.971
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, vivianPHTable, 10, math.random(57600, 86400)) -- 16 to 24 hours
end

return entity
