-----------------------------------
-- Blade: Teki
-- Family: Humanoid Katana Weaponskill
-- Description: Deals water elemental damage. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = mob:getWeaponDmg()
    params.numHits            = 1
    params.fTP                = { 0.5, 0.75, 1.0 }
    -- params.str_wSC         = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC         = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.SLASHING
    params.hybridSkill        = true
    params.hybridSkillElement = xi.element.WATER
    params.hybridAttackType   = xi.attackType.MAGICAL
    params.hybridDamageType   = xi.damageType.WATER
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)
    local totalDamage = 0

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        if info.damage > 0 then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
            totalDamage = totalDamage + info.damage
        end

        if info.hybridDamage > 0 and target:getHP() > 0 then
            target:takeDamage(info.hybridDamage, mob, info.hybridAttackType, info.hybridDamageType)
            totalDamage = totalDamage + info.hybridDamage
        end
    end

    return totalDamage
end

return mobskillObject
