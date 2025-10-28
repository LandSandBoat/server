-----------------------------------
-- Fulmination
--
-- Description: Deals heavy magical damage in an area of effect. Additional effect: Paralysis + Stun
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 30 yalms
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local family = mob:getFamily()
    local mobHPP = mob:getHPP()

    if family == 168 and mobHPP < 35 then -- Khimaira < 35%
        return 0
    elseif family == 315 and mobHPP < 50 then -- Tyger < 50%
        return 0
    elseif family == 316 and mobHPP < 50 then -- Pandemonium Warden
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.THUNDER, 3, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)

    return damage
end

return mobskillObject
