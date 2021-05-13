-----------------------------------
-- Area: Ilrusi Atoll
-- Mob: Percipient Fish
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 4)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
