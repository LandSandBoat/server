-----------------------------------
-- MP Absorption
-- Family: Worms
-- Description: Single target MP Drain.
-- Notes: Ineffective against undead.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = mob:getMainLvl() -- Need more captures. Other MP Drains are often Level - 2.
    params.fTP                  = { 1.5, 1.5, 1.5 }
    params.element              = xi.element.NONE
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipDamageAdjustment = true
    params.skipMagicBonusDiff   = true
    params.skipStoneSkin        = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.MP, info.damage))
    end

    return info.damage
end

return mobskillObject
