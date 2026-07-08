-----------------------------------
-- Mind Wall
-- Description: Activates a magical shield that converts damage taken to HP. Absorbs 100% of magic damage.
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 3 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 3, 0, 30))

    return 0
end

return mobskillObject
