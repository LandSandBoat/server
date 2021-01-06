-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Orcus
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.ORCUS_TROPHY_HUNTER)
end

return entity
