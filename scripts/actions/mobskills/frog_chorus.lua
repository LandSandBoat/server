-----------------------------------
-- Frog Chorus
-- Description: Charms all targets in an area of effect and transforms them into frogs.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return xi.effect.CHARM_I
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, 0, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        target:addStatusEffect(xi.effect.COSTUME, { power = 1812, duration = 60, origin = mob })
    end

    skill:setMsg(msg)

    return xi.effect.CHARM_I
end

return mobskillObject
