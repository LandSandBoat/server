-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Sabotender Sediendo
-- Note: Place Holder for Sabotender Mariachi
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 738, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SABOTENDER_MARIACHI_PH, 5, 10800) -- 3 hour minimum
end

return entity
