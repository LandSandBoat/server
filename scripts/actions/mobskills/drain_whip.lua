-----------------------------------
-- Drain Whip
-- Description: Drains HP, MP, or TP from the target.
-- Type: Magical
-- Utsusemi/Blink absorb: ignores shadows
-- Range: Melee
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local drainEffect = xi.mobskills.drainType.HP
    local dmgmod      = 1
    local info        = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg         = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    local rnd         = math.random(1, 3)

    if rnd == 1 then
        drainEffect = xi.mobskills.drainType.TP
    elseif rnd == 2 then
        drainEffect = xi.mobskills.drainType.MP
    end

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, drainEffect, dmg))

    return dmg
end

return mobskillObject
