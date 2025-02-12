-----------------------------------
-- Implosion
-- Description: Channels a wave of negative energy, damaging all targets in very wide area of effect.
-- Type: Magical
-- Wipes Shadows
-- Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() * 2.75

    -- kinda hacky, need a better control from a mob local var to boost damage
    -- Boosts when Bahamut is able to use Gigaflare according to jimmy's sheet
    if mob:getHPP() <= 10 then
        damage = mob:getMainLvl() * 5.5 
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return damage
end

return mobskillObject
