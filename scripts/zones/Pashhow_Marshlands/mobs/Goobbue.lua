-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Goobbue
-- Note: PH for Jolly Green
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 60, 3, tpz.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.JOLLY_GREEN_PH, 5, 1) -- 1 second / no cooldown
end

return entity
