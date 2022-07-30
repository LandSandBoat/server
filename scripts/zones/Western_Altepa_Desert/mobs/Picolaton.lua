-----------------------------------
-- Area: Western Altepa Desert
--   NM: Picolaton
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 200)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 414)
end

return entity
