-----------------------------------
-- Namas Arrow
-- Skill Level: N/A
-- Description: Additional Effect: Temporarily improves Ranged Accuracy
-- Aligned with the Light Gorget, Snow Gorget & Aqua Gorget.
-- Properties
-- Element: N/A
-- Skillchain Properties: Light/Distortion
-- Modifiers: STR: 40% AGI: 40%
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
--   2.75    2.75    2.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.75, 2.75, 2.75 }
    params.str_wsc = 0.4
    params.agi_wsc = 0.4
    params.overrideCE = 160
    params.overrideVE = 480

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
