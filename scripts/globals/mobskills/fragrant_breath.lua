---------------------------------------------
-- Fragrant Breath
-- Family: Morbol
-- Description: An aromatic scent is exhaled to charms any players in a fan-shaped area of effect.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Conal up to 15'
-- Notes: Some Morbol NMs
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0
    local duration = 60

    if mob:getLocalVar("fragrantbreathduration") ~= nil then
        duration = mob:getLocalVar("fragrantbreathduration")
    end

    if (not target:isPC()) then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, duration)
    if (msg == xi.msg.basic.SKILL_ENFEEB_IS) then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
