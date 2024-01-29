-----------------------------------
-- Enervation
-- Description: Lowers the defense and magical defense of enemies within range.
-- Type: Magical (Dark)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN
    local silenced   = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 10, 0, 120)
    local blinded    = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 8, 0, 120)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    -- display silenced first, else blind
    if silenced == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.DEFENSE_DOWN
    elseif blinded == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.MAGIC_DEF_DOWN
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
