-----------------------------------
-- Sniper Shot
--
-- Description: -- Lowers enemy's INT. Chance of params.critical varies with TP.
-- Type: Ranged
-- Utsusemi/Blink absorb: 1 shadoww
-- Range: 20' yalms
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 210)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numHits = 1
    local accmod = 1
    local ftpMod  = 1

    local info = xi.mobskills.mobRangedMove(mob, target, skill, numHits, accmod, ftpMod, xi.mobskills.physicalTpBonus.CRIT_VARIES)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 10, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    return dmg
end

return mobskillObject
