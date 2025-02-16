-----------------------------------
-- Amon Drive
--
-- Description: Performs an area of effect weaponskill. Additional effect: Paralysis + Petrification + Poison
-- Type: Physical
-- 2-3 Shadows?
-- Range: Melee range radial
-- Special weaponskill unique to Ark Angel TT. Deals ~100-400 damage.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2.5
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, math.random(8, 15) + mob:getMainLvl() / 3)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.ceil(mob:getMainLvl() / 5), 3, 60)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    return dmg
end

return mobskillObject
