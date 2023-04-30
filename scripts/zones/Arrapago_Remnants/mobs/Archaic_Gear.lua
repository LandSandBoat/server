-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Gear
-----------------------------------
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if instance:getStage() == 6 and instance:getProgress() >= 1 then
        if optParams.isKiller then
            xi.assault.progressInstance(mob, 1)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
