-----------------------------------
--  Earth Pounder
--  Description: Deals Earth damage to enemies within area of effect. Additional effect: Dexterity Down
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 15' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local fTP = 2.0

    if mob:getPool() == xi.mobPool.PLATOON_SCORPION then
        local battlefield = mob:getBattlefield()

        if battlefield then
            fTP = fTP + battlefield:getLocalVar('scorpionsDefeated') * .5
        end
    end

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.EARTH, fTP, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 10, 3, 120)

    return damage
end

return mobskillObject
