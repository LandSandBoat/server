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
    mob:setMod(xi.mod.FIREDEF, 128)
    mob:setMod(xi.mod.ICEDEF, 52)
    mob:setMod(xi.mod.WINDDEF, 128)
    mob:setMod(xi.mod.EARTHDEF, 200)
    mob:setMod(xi.mod.THUNDERDEF, 200)
    mob:setMod(xi.mod.WATERDEF, 128)
    mob:setMod(xi.mod.LIGHTDEF, 128)
    mob:setMod(xi.mod.DARKDEF, 128)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 770, 2, xi.regime.type.GROUNDS)
end

return entity
