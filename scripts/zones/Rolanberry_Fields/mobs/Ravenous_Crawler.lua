-----------------------------------
-- Area: Rolanberry Fields
--   NM: Ravenous Crawler
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 217)
end

return entity
