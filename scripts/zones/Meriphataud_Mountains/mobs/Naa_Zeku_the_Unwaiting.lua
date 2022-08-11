-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Naa Zeku the Unwaiting
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 271)
end

return entity
