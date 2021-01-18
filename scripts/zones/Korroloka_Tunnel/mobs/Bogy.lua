-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Bogy
-- Note: PH for Dame Blanche
-----------------------------------
local ID = require("scripts/zones/Korroloka_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 732, 1, tpz.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DAME_BLANCHE_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
