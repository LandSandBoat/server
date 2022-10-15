-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Ironshell
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 805, 1, xi.regime.type.GROUNDS)
end

return entity
