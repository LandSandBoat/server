-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Goblin Mercenary
-- Note: Place Holder for Bloodthirster Madkix
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

local bloodthirsterPHTable =
{
    [ID.mob.BLOODTHIRSTER_MADKIX + 14] = ID.mob.BLOODTHIRSTER_MADKIX, -- 265.000 9.000 30.000
    [ID.mob.BLOODTHIRSTER_MADKIX + 23] = ID.mob.BLOODTHIRSTER_MADKIX, -- 256.000 10.000 34.000
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, bloodthirsterPHTable, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
