-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Rumble Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 791, 2, tpz.regime.type.GROUNDS)
end

return entity
