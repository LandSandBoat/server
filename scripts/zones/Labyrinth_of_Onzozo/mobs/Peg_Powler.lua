-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Peg Powler
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 9200)
    mob:setMobMod(xi.mobMod.MUG_GIL, 4500)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 297)
    xi.regime.checkRegime(player, mob, 774, 1, xi.regime.type.GROUNDS)
end

return entity
