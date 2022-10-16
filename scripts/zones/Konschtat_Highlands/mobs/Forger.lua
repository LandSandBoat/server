-----------------------------------
-- Area: Konschtat Highlands
--   NM: Forger
-----------------------------------
require("scripts/globals/status")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

return entity
