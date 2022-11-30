-----------------------------------
-- Call Beast
-- Call my pet.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:entityAnimationPacket("casm")
    mob:timer(3000, function(mobArg)
        if mobArg:isAlive() then
            mobArg:entityAnimationPacket("shsm")
            mobArg:spawnPet()
        end
    end)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
