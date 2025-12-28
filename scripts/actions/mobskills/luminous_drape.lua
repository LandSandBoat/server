-----------------------------------
-- Luminous Drape
-- Family: Yovra
-- Description: A glowing curtain charms all nearby targets.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: AoE 10'
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return xi.effect.CHARM_I
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, 0, 3, math.random(5, 25))
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return xi.effect.CHARM_I
end

return mobskillObject
