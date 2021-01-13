-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Boyahda Sapling
-- Note: PH for Leshonki
-----------------------------------
local ID = require("scripts/zones/The_Boyahda_Tree/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 725, 1, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.LESHONKI_PH, 5, 3600) -- 1 hour
end

return entity
