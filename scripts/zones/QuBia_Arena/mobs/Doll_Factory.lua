-----------------------------------
-- Area: Qu'Bia Arena
-- Mob: Doll Factory
-- BCNM: Factory Rejects
-----------------------------------
local entity = {}

local function immunity(mob, id)
    if GetMobByID(id):isSpawned() then
        mob:setMod(xi.mod.DMG, -10000)
    else
        mob:setMod(xi.mod.DMG, 0)
    end
end

local function spawnDoll(mob, id)
    mob:setLocalVar("summoning", 1)
    mob:entityAnimationPacket("casm")
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:timer(3000, function(mobArg)
        if mob:isAlive() then
            mobArg:entityAnimationPacket("shsm")
            mobArg:SetAutoAttackEnabled(true)
            mobArg:SetMobAbilityEnabled(true)
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
            SpawnMob(id):updateEnmity(mobArg:getTarget())
            mob:setLocalVar("dollsLeft", mob:getLocalVar("dollsLeft") - 1)
            mob:setLocalVar("dollAlive", 1)
            mob:setLocalVar("summoning", 0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("dollsLeft", 5)
    mob:setLocalVar("currDoll", 1)
    mob:setLocalVar("dollAlive", 0)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("timer", os.time() + math.random(12,20))
end

entity.onMobFight = function(mob, target)
    local id = mob:getID() + mob:getLocalVar("currDoll")

    if
        mob:getLocalVar("timer") < os.time() and
        mob:getLocalVar("dollsLeft") > 0 and
        mob:getLocalVar("dollAlive") == 0 and
        mob:getLocalVar("summoning") == 0
    then
        spawnDoll(mob, id)
    end

    if mob:getLocalVar("dollsLeft") > 1 then
        immunity(mob, id)
    end

    if mob:getLocalVar("dollAlive") == 1 and not GetMobByID(id):isSpawned() then
        mob:setLocalVar("timer", os.time() + math.random(1,2))
        mob:setLocalVar("dollAlive", 0)
        mob:setLocalVar("currDoll", mob:getLocalVar("currDoll") + 1)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
