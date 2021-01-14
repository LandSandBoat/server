-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Dark Aspic
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 610, 1, tpz.regime.type.GROUNDS)
end

return entity
