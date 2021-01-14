-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Tonberry Shadower
-- Note: PH for Hoar-knuckled Rimberry
-----------------------------------
local ID = require("scripts/zones/Yhoator_Jungle/IDs")
mixins = {require("scripts/mixins/families/tonberry")}
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 133, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HOAR_KNUCKLED_RIMBERRY_PH, 10, math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
