-----------------------------------
-- Area: Garlaige Citadel
--   NM: Hazmat
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UFASTCAST, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 300)
end

return entity
