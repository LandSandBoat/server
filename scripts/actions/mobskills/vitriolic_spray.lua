-----------------------------------
-- Vitriolic Spray
-- Family: Wamouracampa
-- Description: Conal AoE Fire damage in front of mob. Additional Effect: Burn
-- Note: Used while in Open form. (Handled via skill list in family mixin)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 4.50, 4.50, 4.50 }
    params.element         = xi.element.FIRE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.FIRE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Is power random? Based off level? Different individuals? Need captures
        -- Sources say Burn is 10-30/tic but does not go into depth.
        -- Personal captures showed 10/tick from Wamoura Prince(Mount Zhayolm). https://youtu.be/2H350wLAlFo?t=228
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, 10, 3, 60)
    end

    return info.damage
end

return mobskillObject
