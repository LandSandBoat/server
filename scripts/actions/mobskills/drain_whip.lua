-----------------------------------
-- Drain Whip
-- Family: Morbols
-- Description: Drains HP, MP, or TP from the target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    local drainType = math.random(xi.mobskills.drainType.HP, xi.mobskills.drainType.TP)

    -- TODO: Is this magical or physical? Need captures
    -- TODO: Are the fTPs the same for each drain type?
    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipMagicBonusDiff = true

    if
        drainType == xi.mobskills.drainType.MP or
        drainType == xi.mobskills.drainType.TP
    then
        params.skipDamageAdjustment = true
        params.skipMagicBonusDiff   = true
        params.skipStoneSkin        = true
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, drainType, info.damage))
    end

    return info.damage
end

return mobskillObject
