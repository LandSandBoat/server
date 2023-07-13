-----------------------------------
-- Area: Cloister of Tides
-- Mob: Leviathan Prime
-- Quest: Waking the Beast
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 21)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("HPThreshold", math.random(10, 90))
    mob:setMod(xi.mod.WATER_ABSORB, 1000)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER, { chance = 100, power = math.random(75, 125) })
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 865 then
        local pos = target:getPos()

        for i = 1, 4 do
            local elemental = GetMobByID(mob:getID() + i)

            if not elemental:isSpawned() then
                SpawnMob(elemental:getID()):updateEnmity(target)
                elemental:setPos(pos.x, pos.y, pos.z, pos.rot)
                break
            end
        end
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("timer", os.time() + math.random(30, 60))
    mob:setLocalVar("hateTimer", os.time() + math.random(10, 20))
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar("control") == 0 and
        mob:getHPP() < mob:getLocalVar("HPThreshold")
    then
        mob:setLocalVar("control", 1)
        mob:useMobAbility(866)
    end

    if mob:getLocalVar("timer") < os.time() then
        for i = 1, 4 do
            local elemental = GetMobByID(mob:getID() + i)

            if elemental:isAlive() then
                elemental:castSpell(xi.magic.spell.WATER_IV, mob)
                mob:setLocalVar("timer", os.time() + math.random(30, 60))
                break
            end
        end
    end

    if mob:getLocalVar("hateTimer") < os.time() then
        for i = 1, 4 do
            local elemental = GetMobByID(mob:getID() + i)

            if elemental:isAlive() then
                elemental:updateEnmity(target)
                mob:setLocalVar("hateTimer", os.time() + math.random(10, 20))
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        for i = 1, 4 do
            if GetMobByID(mob:getID() + i):isAlive() then
                GetMobByID(mob:getID() + i):setHP(0)
            end
        end
    end
end

return entity
