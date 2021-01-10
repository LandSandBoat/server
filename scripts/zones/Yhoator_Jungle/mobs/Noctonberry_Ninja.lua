-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Noctonberry Ninja
-----------------------------------
mixins =
{
    require("scripts/mixins/families/tonberry"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 133, 1, tpz.regime.type.FIELDS)
end

return entity
