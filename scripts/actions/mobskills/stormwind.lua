-----------------------------------
--  Stormwind
--  Description: Creates a whirlwind that deals Wind damage to targets in an area of effect.
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgMod = 3

    -- TODO: Use TP for this? Or literally anything else?
    if mob:getName() == 'Kreutzet' then
        local stormwindDamage = mob:getLocalVar('stormwindDamage')
        if stormwindDamage == 2 then
            dmgMod = 3.25
        elseif stormwindDamage == 3 then
            dmgMod = 3.6
        end
    end

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.WIND, dmgMod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return damage
end

return mobskillObject
