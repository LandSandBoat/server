-----------------------------------
-- Osmosis
-- Family: Amoeban
-- Description: Deals Dark damage to an enemy. Additional Effect: HP Drain, Steals 1 Beneficial Effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getMainLvl() + 2
    params.fTP                = { 5, 5, 5 } -- TODO: Capture fTPs
    params.element            = xi.element.NONE
    params.attackType         = xi.attackType.MAGICAL
    params.damageType         = xi.damageType.NONE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipMagicBonusDiff = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))

        mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE)
    end

    return info.damage
end

return mobskillObject
