-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Qiqirn Mine
-- Note: Explosive mine from Qiqrin
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setUnkillable(true)
    mob:hideName(true)
    mob:untargetable(true)
    mob:hideHP(true)
    mob:SetAutoAttackEnabled(false)
    mob:setStatus(tpz.status.DISAPPEAR)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
end

function onMobDeath(mob, player)
end
