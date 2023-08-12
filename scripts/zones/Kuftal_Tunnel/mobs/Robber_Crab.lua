-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Robber Crab
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.CANCER + 1 then
        mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 735, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 736, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 738, 1, xi.regime.type.GROUNDS)
end

return entity
