-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Robber Crab
-----------------------------------
local ID = require("scripts/zones/Kuftal_Tunnel/IDs")
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.CANCER + 1 then
        mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 735, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 736, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 738, 1, tpz.regime.type.GROUNDS)
end

return entity
