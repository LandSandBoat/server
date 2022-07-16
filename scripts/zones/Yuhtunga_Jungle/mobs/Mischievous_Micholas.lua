-----------------------------------
-- Area: Yuhtunga Jungle
--   NM: Mischievous Micholas
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 75)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 362)
    xi.regime.checkRegime(player, mob, 126, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 128, 1, xi.regime.type.FIELDS)
end

return entity
