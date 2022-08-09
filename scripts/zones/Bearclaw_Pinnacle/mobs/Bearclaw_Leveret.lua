-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Bearclaw Leveret
-- ENM: Follow the White Rabbit
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

return entity
