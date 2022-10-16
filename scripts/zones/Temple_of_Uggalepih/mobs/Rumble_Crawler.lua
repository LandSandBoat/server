-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Rumble Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 791, 2, xi.regime.type.GROUNDS)
end

return entity
