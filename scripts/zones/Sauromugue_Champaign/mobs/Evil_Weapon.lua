-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Evil Weapon
-- Note: PH for Blighting Brand
-----------------------------------
local ID = require("scripts/zones/Sauromugue_Champaign/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 100, 2, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BLIGHTING_BRAND_PH, 20, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
