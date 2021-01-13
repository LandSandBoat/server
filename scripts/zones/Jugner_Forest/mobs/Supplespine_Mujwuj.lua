-----------------------------------
-- Area: Jugner Forest
--   NM: Supplespine Mujwuj
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 160)
end

return entity
