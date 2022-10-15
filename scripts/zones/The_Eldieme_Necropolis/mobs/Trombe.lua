-----------------------------------
-- Area: The Eldieme Necropolis
--  MOB:  Trombe
-- Involved in Quest: A New Dawn (BST AF3)
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
