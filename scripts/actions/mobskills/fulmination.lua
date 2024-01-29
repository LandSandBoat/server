-----------------------------------
-- Fulmination
--
-- Description: Deals heavy magical damage in an area of effect. Additional effect: Paralysis + Stun
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes Shadows
-- Range: 30 yalms
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local family = mob:getFamily()
    local mobhp = mob:getHPP()
    local result = 1

    if family == 168 and mobhp <= 35 then -- Khimaira < 35%
        result = 0
    elseif family == 315 and mobhp <= 50 then -- Tyger < 50%
        result = 0
    elseif family == 316 then
        result = 0
    end

    return result
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Hits all players near Khimaira, not just alliance.

    local dmgmod = 3
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.element.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    return dmg
end

return mobskillObject
