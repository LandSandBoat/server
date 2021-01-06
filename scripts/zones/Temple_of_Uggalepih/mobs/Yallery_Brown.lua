-----------------------------------
-- Area: Temple of Uggalepih (159)
--   NM: Yallery Brown
-- Note: Popped by qm9
-- Involved in Quest: Axe The Competition
-- !pos 220 -8.11 205.38 159
-----------------------------------
require("scripts/globals/wsquest")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.decimation, player)
end

return entity
