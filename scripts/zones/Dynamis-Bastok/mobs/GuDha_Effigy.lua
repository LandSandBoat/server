-----------------------------------
-- Area: Dynamis - Bastok
--  Mob: Gu'Dha Effigy
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
end

return entity
