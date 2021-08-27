-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Nachtmahr
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 616, 1, xi.regime.type.GROUNDS)
end

return entity
