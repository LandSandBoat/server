-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Snoll Tzar
-- ENM: When Hell Freezes Over
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

local controlBombs =
{
    {16801818, 16801821},
    {16801826, 16801829},
    {16801832, 16801835},
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 75)
    mob:setMod(xi.mod.LULLABYRES, 75)

    mob:timer(1, function(mobArg)
        local bfNum = mobArg:getBattlefield():getArea()
        local bf = mobArg:getBattlefield()

        for i = 1, 2 do
            if mobArg:getID() == controlBombs[bfNum][i] then
                bf:setLocalVar("mobsDead", 0)
                bf:setLocalVar("controlBombID", controlBombs[bfNum][i])
                bf:setLocalVar("adds", math.random(0,2))

                if bf:getLocalVar("wave") == 0 then
                    bf:setLocalVar("adds", 2)
                else
                    for y = 1, bf:getLocalVar("adds") do
                        SpawnMob(mobArg:getID() + y)
                    end
                end
            end
        end
    end)

    mob:addListener("TAKE_DAMAGE", "DEVIL_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if amount > mobArg:getHP() then
            local bfNum = mob:getBattlefield():getArea()
            local bf = mob:getBattlefield()
            bf:setLocalVar("mobsDead", bf:getLocalVar("mobsDead") + 1)
            if
                bf:getLocalVar("mobsDead") >= bf:getLocalVar("adds") + 1 and
                bf:getLocalVar("wave") < 3
            then
                bf:setLocalVar("wave", bf:getLocalVar("wave") + 1)
                if bf:getLocalVar("controlBombID") == controlBombs[bfNum][1] then
                    SpawnMob(controlBombs[bfNum][2])
                else
                    SpawnMob(controlBombs[bfNum][1])
                end
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
