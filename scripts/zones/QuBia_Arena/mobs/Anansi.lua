-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Anansi
-- BCNM: Come into my Parlor
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
    for i = 2, 9 do
        mob:timer(math.random(2,8)*1000, function(mobArg)
            SpawnMob(mobArg:getID()+i):setSpawn(mobArg:getPos())
        end)
    end
end

return entity
