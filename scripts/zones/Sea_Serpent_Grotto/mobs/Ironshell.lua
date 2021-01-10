-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Ironshell
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 805, 1, tpz.regime.type.GROUNDS)
end

return entity
