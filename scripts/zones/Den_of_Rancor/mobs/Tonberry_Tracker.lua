-----------------------------------
-- Area: Den of Rancor
--   NM: Tonberry Tracker
-----------------------------------
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 798, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 799, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 800, 2, tpz.regime.type.GROUNDS)
end

return entity
