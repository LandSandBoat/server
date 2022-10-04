-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Erlik
-- Note: Place holder Baobhan Sith
-----------------------------------
local ID = require("scripts/zones/Gustav_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 767, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BAOBHAN_SITH_PH, 5, math.random(14400, 28800)) -- 4 to 8 hours
end

return entity
