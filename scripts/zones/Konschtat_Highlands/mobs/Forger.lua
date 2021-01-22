-----------------------------------
-- Area: Konschtat Highlands
--   NM: Forger
-----------------------------------
require("scripts/globals/status")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.tutorial.onMobDeath(player)
end

return entity
