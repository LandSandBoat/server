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

    mob:addListener("DEATH", "ANANSI_DEATH", function(mobArg, killer)
        if killer then
            mobArg:setHP(1)
            local target = killer
            if target:isPet() then
                target = target:getMaster()
            end
            mobArg:timer(math.random(2,6)*1000, function(mobArg2)
            end)
            for i = 2, 9 do
                print("entered for loop")
                local spider = mobArg:getID() + i

                mobArg:timer(1000, function(mobArg2)
                    SpawnMob(spider):setSpawn(mobArg:getPos())
                    spider:updateClaim(killer)
                    spider:updateEnmity(killer)
                end)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
