-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Hurricane Wyvern
-- Note: PH for Vouivre
-----------------------------------
local ID = require("scripts/zones/Ifrits_Cauldron/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 762, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VOUIVRE_PH, 5, 7200) -- 2 hours
end

return entity
