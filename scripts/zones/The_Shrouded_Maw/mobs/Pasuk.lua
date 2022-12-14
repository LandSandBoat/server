-----------------------------------
-- Area: The Shrouded Maw
-- Mob: Pasuk
-- ENM: Test your Mite
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 100, power = math.random(200, 260) })
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("timer", os.time() + 30)
    mob:setSpeed(30)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1361 then
        if mob:getLocalVar("hateWipe") == 1 then
            mob:setLocalVar("hateWipe", 0)
            mob:resetEnmity(target)
        else
            mob:setLocalVar("hateWipe", 1)
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar("timer") < os.time() then
        if mob:checkDistance(target) > 14 then
            mob:timer(2000, function(mobArg)
                local pos = target:getPos()
                mobArg:setPos(pos.x + 1, pos.y, pos.z + 1)
                mobArg:setLocalVar("timer", os.time() + 30)
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
