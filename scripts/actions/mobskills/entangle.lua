-----------------------------------
-- Entangle
--
-- Description: Attempts to bind a single target with vines.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: When used by the Cemetery Cherry and leafless Jidra: it also deals damage, inflicts Poison, and resets hate.
--        When used by Cernunnos: deals damage, also drains HP equal to the damage inflicted.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getName() == 'Cernunnos' then
        local numhits = 3
        local accmod = 1
        local ftp    = 2.0
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

        xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill,  xi.effect.BIND, 1, 0, 30)

        return dmg
    elseif mob:getPool() == 671 or mob:getPool() == 1346 then -- Cemetery Cherry and leafless Jidra
        local numhits = 3
        local accmod = 1
        local ftp    = 2.0
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

        mob:resetEnmity(target)
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING, { breakBind = false })
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30))
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 50, 0, 60)

        return xi.effect.BIND
    else
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30))
        return xi.effect.BIND
    end
end

return mobskillObject
