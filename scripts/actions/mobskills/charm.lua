-----------------------------------
-- Charm
-----------------------------------
---@type TMobSkill
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

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, power, 3, 180)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)

    return xi.effect.CHARM_I
end

return mobskillObject
