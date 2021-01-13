-----------------------------------
-- Area: Kuftal Tunnel (174)
--   NM: Kettenkaefer
-- Note: Popped by qm3
-- !pos 204.052 10.25 96.414 174
-- Involved in Quest: The Potential Within
-----------------------------------
require("scripts/globals/wsquest")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.tachi_kasha, player)
end

return entity
