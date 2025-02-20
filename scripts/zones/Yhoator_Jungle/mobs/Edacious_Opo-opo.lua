-----------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 366)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('cooldown', os.time() + 900)
end

return entity
