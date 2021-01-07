-----------------------------------
-- Area: Lufaise Meadows
--   NM: Megalobugard
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.REGEN, 25)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 439)
end

return entity
