-----------------------------------
-- Uriel Blade
-- Family: Humanoid Sword Weaponskill
-- Delivers an area attack that deals light elemental damage. Additional effect: Flash. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, xi.weaponskill.URIEL_BLADE)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 4.5, 6.0, 7.5 }
    params.accuracyModifier = { 100, 100, 100 }
    params.str_wSC        = 0.32
    params.mnd_wSC        = 0.32
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    if skill:getTP() < 1000 then
        params.fTPBonus = 1000
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 0, 0, 15)
    end

    return info.damage
end

return mobskillObject
