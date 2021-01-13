-----------------------------------
-- Area: Western Altepa Desert
--   NM: Calchas
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 33)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 415)
end

return entity
