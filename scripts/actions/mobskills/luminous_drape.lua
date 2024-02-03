-----------------------------------
-- Luminous Drape
-- Family: Yovra
-- Description: A glowing curtain charms all nearby targets.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: AoE 10'
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return xi.effect.CHARM_I
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    skill:setMsg(msg)

    return xi.effect.CHARM_I
end

return mobskillObject
