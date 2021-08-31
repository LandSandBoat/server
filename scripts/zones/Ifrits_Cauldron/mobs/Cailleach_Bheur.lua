-----------------------------------
-- Area: Ifrit's Cauldron (205)
--  Mob: Cailleach Bheur
-- Note: Popped by qm3
-- Involved in Quest: Blood and Glory
-- !pos 117.074 19.403 144.834 205
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
