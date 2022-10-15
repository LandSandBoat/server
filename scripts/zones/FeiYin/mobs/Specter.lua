-----------------------------------
-- Area: Fei'Yin
--  Mob: Specter
-- Note: PH for N/E/S/W Shadow NMs
-----------------------------------
require("scripts/globals/regimes")
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 712, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NORTHERN_SHADOW_PH, 5, 57600) -- 16 hours
    xi.mob.phOnDespawn(mob, ID.mob.EASTERN_SHADOW_PH, 5, 36000) -- 10 hours
    xi.mob.phOnDespawn(mob, ID.mob.WESTERN_SHADOW_PH, 5, 36000) -- 10 hours
    xi.mob.phOnDespawn(mob, ID.mob.SOUTHERN_SHADOW_PH, 5, 57600) -- 16 hours
end

return entity
