-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Veindigger Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 630, 2, tpz.regime.type.GROUNDS)
end

return entity
