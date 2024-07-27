-----------------------------------
-- Fragrant Breath
-- Family: Morbol
-- Description: An aromatic scent is exhaled to charms any players in a fan-shaped area of effect.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores Shadows
-- Range: Conal up to 12 or 20 depending on which NM was killed
-- Notes: Only used by Cirrate Christelle
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local duration = 30

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    end

    if skill:getID() == 1606 then -- Weaker version
        duration = 15
    end

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 0, 3, duration)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
