-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Bearclaw Leveret
-- ENM: Follow the White Rabbit
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

return entity
