-----------------------------------
-- TP Drainkiss
-- Family: Leech
-- Description: Steals a targets TP. TP stolen varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = target:getTP()
    params.fTP                  = { 0.500, 0.666, 0.833 } -- TODO: Need more capture samples
    -- Note: This has been observed to absorb less than 50% TP(1400~ @ Player: 3000TP, Mob 1000 TP)
    -- Also seen to absorb 2000+ TP at Player: 3000% TP, Mob 3000% TP. Interpolating the 2000 TP anchor linearly for now.
    params.element              = xi.element.NONE
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipDamageAdjustment = true
    params.skipMagicBonusDiff   = true
    params.skipStoneSkin        = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.TP, info.damage))
    end

    return info.damage
end

return mobskillObject
