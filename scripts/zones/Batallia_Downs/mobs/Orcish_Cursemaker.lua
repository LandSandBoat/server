-----------------------------------
-- Area: Batallia Downs
--  Mob: Orcish Cursemaker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 74, 3, tpz.regime.type.FIELDS)
end

return entity
