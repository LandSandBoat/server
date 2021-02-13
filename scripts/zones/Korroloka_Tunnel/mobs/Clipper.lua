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

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 731, 1, tpz.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CARGO_CRAB_COLIN_PH, 5, math.random(7200, 21600)) -- 1 to 6 hours
end

return entity
