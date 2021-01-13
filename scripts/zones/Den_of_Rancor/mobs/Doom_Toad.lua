-----------------------------------
-- Area: Den of Rancor
--  Mob: Doom Toad
-- Note: PH for Ogama
-----------------------------------
local ID = require("scripts/zones/Den_of_Rancor/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 801, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.OGAMA_PH, 5, 3600) -- 1 hour
end

return entity
