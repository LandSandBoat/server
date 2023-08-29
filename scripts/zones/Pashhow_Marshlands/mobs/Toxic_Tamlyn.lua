-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Toxic Tamlyn
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 213)
    mob:setLocalVar('spawnTime', 3600 + os.time()) -- 1 hour
end

return entity
