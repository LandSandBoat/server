---------------------------------------------
-- Call Wyvern
-- Call my pet.
---------------------------------------------
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:hasPet() or mob:getPet() == nil then
        return 1
    end

    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    mob:spawnPet()

    skill:setMsg(tpz.msg.basic.NONE)

    return 0
end

return mobskill_object
