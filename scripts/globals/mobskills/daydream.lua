-----------------------------------
-- Daydream
-- Diabolos Diamond - Dynamis Tavnazia
-- Description: Charms a target
-- Type: Enfeebling
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local power = 0

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        target:delStatusEffect(xi.effect.SLEEP_I)
        mob:charm(target)
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
