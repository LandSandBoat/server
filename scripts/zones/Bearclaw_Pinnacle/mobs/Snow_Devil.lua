-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Snoll Tzar
-- ENM: When Hell Freezes Over
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

local controlDevils =
{
    {16801818, 16801821},
    {16801826, 16801829},
    {16801834, 16801837},
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 75)
    mob:setMod(xi.mod.LULLABYRES, 75)
end

entity.onMobSpawn = function(mob)
    mob:addListener("DEATH", "DEVIL_DEATH", function(bomb, killer)
        local bf = mob:getBattlefield()
        local bfNum = bf:getArea()
        bf:setLocalVar("mobsDead", bf:getLocalVar("mobsDead") + 1)

        if bf:getLocalVar("mobsDead") >= bf:getLocalVar("adds") + 1 then
            bf:setLocalVar("wave", bf:getLocalVar("wave") + 1)

            if bf:getLocalVar("wave") >= 4 then
                bf:setLocalVar("lootSpawned", 0)
            else
                bf:setLocalVar("adds", math.random(0, 2))
                bf:setLocalVar("mobsDead", 0)

                for i = 0, bf:getLocalVar("adds") do
                    if bf:getLocalVar("wave") % 2 == 1 then
                        SpawnMob(controlDevils[bfNum][2]+i)
                    else
                        SpawnMob(controlDevils[bfNum][1]+i)
                    end
                end
            end
        end

        -- Despawn bombs quicker than normal to prevent deadlock where bombs don't respawn
        bomb:timer(5000, function(mobArg)
            DespawnMob(mobArg:getID())
        end)
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
