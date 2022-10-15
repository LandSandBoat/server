-----------------------------------
-- Area: West Ronfaure
--  Mob: Marauder Dvogzog
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 4, 1, xi.regime.type.FIELDS)
end

return entity
