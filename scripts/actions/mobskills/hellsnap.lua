-----------------------------------
-- Hellsnap
-- Stuns targets in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 4
    if mob:isNM() then
        duration = 10
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, duration))

    return xi.effect.STUN
end

return mobskillObject
