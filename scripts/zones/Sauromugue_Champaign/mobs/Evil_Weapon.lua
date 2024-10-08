-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Evil Weapon
-- Note: PH for Blighting Brand
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
---@type TMobEntity
local entity = {}

local brandPHTable =
{
    [ID.mob.BLIGHTING_BRAND - 3] = ID.mob.BLIGHTING_BRAND, -- 240.725 1.853 223.185
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 100, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, brandPHTable, 20, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
