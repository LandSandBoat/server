-----------------------------------
--  Chaos Blade
--
--  Description: Deals Dark damage to enemies within a fan-shaped area. Additional effect: Curse
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores Shadows
--  Range: Melee
--  Notes:
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local power = 25
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:lookAt(target:getPos())
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    if mob:getPool() == 1100 or mob:getPool() == 1101 then
        power = mob:getLocalVar("chaosBladeLevel")
    end

    -- curse LAST so you don't die
    local typeEffect = xi.effect.CURSE_I
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, 420)

    return dmg
end

return mobskillObject
