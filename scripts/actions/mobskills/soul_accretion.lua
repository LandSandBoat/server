-----------------------------------
-- Soul Accretion
-- Attempts to absorb one buff from a single target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dispel = mob:stealStatusEffect(target, bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))
    local msg    = xi.msg.basic.SKILL_NO_EFFECT

    if dispel > 0 then
        msg = xi.msg.basic.EFFECT_DRAINED
    end

    skill:setMsg(msg)

    return 1
end

return mobskillObject
