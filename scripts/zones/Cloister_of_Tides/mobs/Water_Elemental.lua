-----------------------------------
-- Area: Cloister of Tides
-- Mob: Water Elemental
-- Quest: Waking the Beast
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UDMGPHYS, -2500)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
