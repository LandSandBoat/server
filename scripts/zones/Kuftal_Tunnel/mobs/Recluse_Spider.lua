-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Recluse Spider
-- Note: Place Holder for Arachne
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 737, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 739, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.ARACHNE_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
