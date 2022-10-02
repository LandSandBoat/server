-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Clipper
-- Note: PH for Cargo Crab Colin
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 731, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CARGO_CRAB_COLIN_PH, 5, 5400) -- 1 1/2 hr minimum
end

return entity
