-----------------------------------
-- Area: Ro'Maeve (122)
--  Mob: Eldhrimnir
-- Note: Popped by qm1
-- Involved in Quest: Orastery Woes
-- !pos 200.3 -11 -24.8 122
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
