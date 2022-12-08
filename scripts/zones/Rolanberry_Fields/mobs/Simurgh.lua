-----------------------------------
-- Area: Rolanberry Fields (110)
--  HNM: Simurgh
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
    require("scripts/mixins/job_special")
}
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 100)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("drawInTime", os.time() + 20)
end

entity.onMobFight = function(mob, target)
    -- Draws in targeted member every 8 to 20 seconds
    local drawInTime = mob:getLocalVar("drawInTime")

    if os.time() > drawInTime then
        mob:triggerDrawIn(mob, false, 1, 35, target)
        mob:setLocalVar("drawInTime", os.time() + math.random(8, 20))
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SIMURGH_POACHER)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
