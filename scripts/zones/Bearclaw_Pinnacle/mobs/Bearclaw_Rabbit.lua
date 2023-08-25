-----------------------------------
-- Area: Bearclaw Pinnacle
-- Mob: Bearclaw Rabbit
-- ENM: Follow the White Rabbit
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
end

entity.onMobEngaged = function(mob)
    mob:setLocalVar("timer", os.time() + 60)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("timer") < os.time() and mob:getLocalVar("spawnControl") == 0 then
        mob:setLocalVar("spawnControl", 1)
        mob:setLocalVar("deathID", math.random(1,5))

        for i = 1, 5 do
            SpawnMob(mob:getID()+i):updateEnmity(target)
        end
    end

    if
        GetMobByID(mob:getID() + mob:getLocalVar("deathID")):isDead() and
        mob:getLocalVar("spawnControl") == 1 and
        mob:getLocalVar("deathControl") == 0
    then
        mob:setLocalVar("deathControl", 1)
        mob:useMobAbility(688)
        mob:addMod(xi.mod.ATT, 60)

        for i = 1, 5 do
            if GetMobByID(mob:getID()+i):isAlive() then
                GetMobByID(mob:getID()+i):setHP(0)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
