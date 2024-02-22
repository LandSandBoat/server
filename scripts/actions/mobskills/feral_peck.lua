-----------------------------------
--  Feral Peck
--    Mob Ability: 2429
--  Description: Deals a set amount of heavy damage (seems like ~90% of target's current HP) to a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: Needs retail verification
--  Range: Melee
--  Notes: Used only by Zirnitra and Turul
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage    = target:getHP()

    -- If have more hp then 30%, then reduce a 10%
    if target:getHPP() > 30 then
        damage = damage * 0.9
    end

    local dmg = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
