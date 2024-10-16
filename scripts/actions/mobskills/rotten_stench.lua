-----------------------------------
-- Rotten Stench
-- Lowers physical and magic accuracy of enemies in an area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power        = 50
    local duration     = math.random(90, 120)
    local accuracyDown = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, power, 0, duration)
    local magicAccDown = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_ACC_DOWN, power, 0, duration)
    local typeEffect   = 0

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB)

    if accuracyDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.ACCURACY_DOWN
    elseif magicAccDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.MAGIC_ACC_DOWN
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end

return mobskillObject
