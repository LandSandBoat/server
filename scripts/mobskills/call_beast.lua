-----------------------------------
-- Call Beast
-- Call my pet.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:spawnPet()

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
