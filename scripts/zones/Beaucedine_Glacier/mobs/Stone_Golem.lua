-----------------------------------
-- Area: Beaucedine Glacier (111)
--  Mob: Stone Golem
-- Note: PH for Gargantua
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
local entity = {}

local gargantuaPHTable =
{
    [ID.mob.GARGANTUA - 1] = ID.mob.GARGANTUA, -- 339 -0.472 -20
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, gargantuaPHTable, 5, math.random(3600, 25200)) -- 1 to 7 hours
end

return entity
