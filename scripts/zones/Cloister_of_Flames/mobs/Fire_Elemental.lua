-----------------------------------
-- Area: Cloister of Flames
-- Mob: Fire Elemental
-- Quest: Waking the Beast
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UDMGPHYS, -2500)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
