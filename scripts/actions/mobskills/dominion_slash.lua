-----------------------------------
-- Dominion Slash
-- Description: Performs an area of effect slashing weaponskill. Additional effect: Silence
-- Type: Physical
-- 2-3 Shadows
-- Range: Unknown radial
-- One source also mentions that it "can dispel important buffs."
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Can skillchain?  Unknown property.

    local numhits = 1
    local accmod = 1
    local ftp    = 3.25
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    -- Due to conflicting information, making the dispel resistable.  Correct/tweak if wrong.
    -- Dispel has no status effect or resistance gear, so 0s instead of nulls.
    local resist = xi.mobskills.applyPlayerResistance(mob, 0, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 0, xi.element.LIGHT)
    if resist > 0.0625 then
        target:dispelStatusEffect()
    end

    -- TODO: Dispel message

    -- Damage is HIGHLY conflicting.  Witnessed anywhere from 300 to 900.
    -- TP DMG VARIES can sort of account for this, but I feel like it's still not right.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
