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
    Todo: make sure their get migrated to mob_resistances.sql
    ..And make sure these are 1000 scaled instead of 256 scaled..
    ]]
    mob:setMod(xi.mod.FIRE_SDT, 128)
    mob:setMod(xi.mod.ICE_SDT, 52)
    mob:setMod(xi.mod.WIND_SDT, 128)
    mob:setMod(xi.mod.EARTH_SDT, 200)
    mob:setMod(xi.mod.THUNDER_SDT, 200)
    mob:setMod(xi.mod.WATER_SDT, 128)
    mob:setMod(xi.mod.LIGHT_SDT, 128)
    mob:setMod(xi.mod.DARK_SDT, 128)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 770, 2, xi.regime.type.GROUNDS)
end

return entity
