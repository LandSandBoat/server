-----------------------------------
--  Transmogrification
--  Description: Activates a physical shield that converts damage taken to HP. Absorbs 100% of physical damage.
--  Type: Physical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PHYSICAL_SHIELD, 2, 0, 30))

    return 0
end

return mobskillObject
