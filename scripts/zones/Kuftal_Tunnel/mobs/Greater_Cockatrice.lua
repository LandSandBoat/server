-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Greater Cockatrice
-- Note: Place Holder for Pelican
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 741, 2, tpz.regime.type.GROUNDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.PELICAN_PH, 5, math.random(10800, 43200)) -- 4 to 12 hours
end

return entity
