-----------------------------------
-- Area: Uleguerand Range
--   NM: Mountain Worm
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGEN, 50)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar("disengage", 0)
end

entity.onMobDisengage = function(mob)
    -- According to wiki, Mountain Worm will despawn shortly
    --  after disengaging. 10 seconds is being assumed and
    --  needs further information
    mob:setLocalVar("disengage", 1)
    mob:timer(10000, function(mobArg)
        if mob:getLocalVar("disengage") == 1 then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobDewpawn = function(mob)
    xi.mob.nmTODPersist(mob, 75600) -- 21 hours
end

return entity
