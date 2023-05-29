-----------------------------------
-- Area: Uleguerand Range
--   NM: Mountain Worm
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == 16798031 then
        mob:addMod(xi.mod.REGEN, 50)
    end
end

entity.onMobDisengage = function(mob)
    -- According to wiki, Mountain Worm will despawn shortly
    --  after disengaging. 10 seconds is being assumed and
    --  needs further information
    mob:timer(10000, function(mobArg)
        if not mob:isEngaged() then
            DespawnMob(mobArg:getID())
        end
    end)
end

entity.onMobDewpawn = function(mob)
    xi.mob.nmTODPersist(mob, 75600) -- 21 hours
end

return entity
