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
    local accmod  = 1
    local ftp     = 3.25 -- fTP and fTP scaling unknown. TODO: capture ftp
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    -- Damage is HIGHLY conflicting.  Witnessed anywhere from 300 to 900.
    -- TP DMG VARIES can sort of account for this, but I feel like it's still not right.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    -- Due to conflicting information, making the dispel resistable.  Correct/tweak if wrong.
    -- Dispel has no status effect or resistance gear, so 0s instead of nulls.
    local resistRate = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, 0, xi.element.LIGHT, xi.mod.INT, xi.effect.NONE, 0)
    if resistRate >= 0.25 then
        target:dispelStatusEffect()
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    return dmg
end

return mobskillObject
