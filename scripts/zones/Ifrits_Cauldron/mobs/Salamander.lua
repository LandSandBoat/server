-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Salamander
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
