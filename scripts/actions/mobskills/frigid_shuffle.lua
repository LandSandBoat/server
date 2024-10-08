-----------------------------------
-- Frigid Shuffle
-- Description: An icy waltz paralyzes targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return xi.apkallu.canUseAbility(mob, 30)
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:isFacing(mob) then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return
    end

    local duration = math.random(60, 120)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, duration))

    return xi.effect.PARALYSIS
end

return mobskillObject
