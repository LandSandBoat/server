-----------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Wallbreacher
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 169)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3900, 5400)) -- 65 to 90 min
end

return entity
