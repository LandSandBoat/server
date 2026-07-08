-----------------------------------
-- Nullsong
-- Family: Dragon
-- Description: Removes all beneficial effects from players in an area of effect. Deals darkness damage for each buff removed.
-- Note: Only used if target has 3 or more effects to dispel
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:hasStatusEffect(xi.effect.SILENCE) or
        target:countEffectWithFlag(xi.effectFlag.DISPELABLE) < 3
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    local count = target:dispelAllStatusEffect(xi.effectFlag.DISPELABLE)

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return count
    end

    params.baseDamage           = 117
    params.fTP                  = { count, count, count }
    params.element              = xi.element.NONE
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipDamageAdjustment = true -- TODO: Affected by shell?
    params.skipMagicBonusDiff   = true -- TODO: Affected by MDB?

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
