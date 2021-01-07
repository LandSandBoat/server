-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Pygmytoise
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    --[[
    Attempt to Aproximate retail damage ratios,
    the current resist rates can't do the job..
    What retail appears to do per info on BG is FORCE a minimum resist teir
    along with a damage bonus on ice (all spell get a partial resist).
    These are annoyingly x/256 scaled.
    ]]
    mob:setMod(tpz.mod.FIREDEF, 128)
    mob:setMod(tpz.mod.ICEDEF, 52)
    mob:setMod(tpz.mod.WINDDEF, 128)
    mob:setMod(tpz.mod.EARTHDEF, 200)
    mob:setMod(tpz.mod.THUNDERDEF, 200)
    mob:setMod(tpz.mod.WATERDEF, 128)
    mob:setMod(tpz.mod.LIGHTDEF, 128)
    mob:setMod(tpz.mod.DARKDEF, 128)
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 770, 2, tpz.regime.type.GROUNDS)
end

return entity
