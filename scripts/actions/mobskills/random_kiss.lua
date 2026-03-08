-----------------------------------
-- Random Kiss
-- Family: Leech
-- Description: Drains HP/MP/TP chosen at random.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getMainLvl()  -- TODO: MP Drains often use Level - 2, take into consideration when capturing/calculating.
    params.fTP                = { 2.9, 2.9, 2.9 } -- TODO: Capture fTPs. Check fTPs for each type of drain.
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Check shadows for each drain type.
    params.skipMagicBonusDiff = true

    -- TODO: This probably isn't the ideal but will address in a future PR.
    --       Need to think about how to structure/handle drains better.
    local drainType = math.random(xi.mobskills.drainType.HP, xi.mobskills.drainType.TP)

    if
        drainType == xi.mobskills.drainType.MP or
        drainType == xi.mobskills.drainType.TP
    then
        params.skipDamageAdjustment = true
        params.skipStoneSkin        = true
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, drainType, info.damage))
    end

    return info.damage
end

return mobskillObject
