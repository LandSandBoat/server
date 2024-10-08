-----------------------------------
-- Area: Konschtat Highlands
--   NM: Forger
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

return entity
