-----------------------------------
-- Call Beast
-- Call my pet.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Don't summon if a pet is already out
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    -- If it's not already out, make sure we're passed the minimum time
    if os.time() < mob:getLocalVar("CallBeastTime") then
        return 1
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar("CallBeastTime", os.time() + 120 + math.random(30))
    skill:setMsg(xi.msg.basic.NONE)

    mob:entityAnimationPacket("casm")
    mob:timer(3000, function(m)
        if m:isAlive() then
            m:entityAnimationPacket("shsm")
            m:spawnPet()
        end
    end)
end

return mobskillObject
