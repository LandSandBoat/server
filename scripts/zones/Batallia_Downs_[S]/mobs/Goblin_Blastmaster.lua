-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Goblin Blastmaster
-- Note: PH for Burlibix Brawnback
-----------------------------------
local ID = zones[xi.zone.BATALLIA_DOWNS_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local burlibixPHTable =
{
    [ID.mob.BURLIBIX_BRAWNBACK - 1] = ID.mob.BURLIBIX_BRAWNBACK,
    [ID.mob.BURLIBIX_BRAWNBACK + 3] = ID.mob.BURLIBIX_BRAWNBACK,
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, burlibixPHTable, 10, 10800) -- 3 hours
end

return entity
