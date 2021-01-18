-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Sulfur Scorpion
-- Note: PH for Tyrannic Turrok
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 759, 2, tpz.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TYRANNIC_TURROK_PH, 5, 3600) -- 1 hour
end

return entity
