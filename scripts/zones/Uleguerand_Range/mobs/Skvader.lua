-----------------------------------
-- Area: Uleguerand Range
--   NM: Skvader
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 321)
end

return entity
