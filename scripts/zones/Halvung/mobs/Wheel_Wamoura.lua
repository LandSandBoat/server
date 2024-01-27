-----------------------------------
-- Area: Halvung
--  Mob: Wheel Wamoura
-- TODO: Damage resistances in streched and curled stances. Halting movement during stance change.
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('formTime', os.time() + math.random(43, 47))
end

entity.onMobRoam = function(mob)
    local roamTime = mob:getLocalVar('formTime')

    if mob:getAnimationSub() == 0 and os.time() > roamTime then
        mob:setAnimationSub(1)
        mob:setLocalVar('formTime', os.time() + math.random(43, 47))
    elseif mob:getAnimationSub() == 1 and os.time() > roamTime then
        mob:setAnimationSub(0)
        mob:setLocalVar('formTime', os.time() + math.random(43, 47))
    end
end

entity.onMobFight = function(mob, target)
    local fightTime = mob:getLocalVar('formTime')

    if mob:getAnimationSub() == 0 and os.time() > fightTime then
        mob:setAnimationSub(1)
        mob:setLocalVar('formTime', os.time() + math.random(43, 47))
    elseif mob:getAnimationSub() == 1 and os.time() > fightTime then
        mob:setAnimationSub(0)
        mob:setLocalVar('formTime', os.time() + math.random(43, 47))
    end
end

entity.onMobDeath = function(mob)
end

return entity
