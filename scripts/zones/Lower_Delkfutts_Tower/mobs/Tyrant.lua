-----------------------------------
-- Area: Lower Delkfutt's Tower
--   NM: Tyrant
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 14)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 343)
end

return entity
