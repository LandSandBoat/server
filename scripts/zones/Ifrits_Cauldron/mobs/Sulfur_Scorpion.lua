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

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 759, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TYRANNIC_TUNNOK_PH, 5, 3600) -- 1 hour
end

return entity
