-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Evil Weapon
-- Note: PH for Blighting Brand
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 100, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLIGHTING_BRAND_PH, 20, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
