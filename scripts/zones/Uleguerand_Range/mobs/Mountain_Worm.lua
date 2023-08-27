-----------------------------------
-- Area: Uleguerand Range
--   NM: Mountain Worm
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.MOUNTAIN_WORM then
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

entity.onMobDespawn = function(mob)
    if mob:getID() == ID.mob.MOUNTAIN_WORM then
        xi.mob.nmTODPersist(mob, 75600) -- 21 hours
    end
end

return entity
