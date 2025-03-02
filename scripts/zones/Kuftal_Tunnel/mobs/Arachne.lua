-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Arachne
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 6000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 6000)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 420)
end

return entity
