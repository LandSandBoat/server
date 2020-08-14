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
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 2.75 params.ftp200 = 2.75 params.ftp300 = 2.75
    params.str_wsc = 0.4 params.dex_wsc = 0.0 params.vit_wsc = 0.0
    params.agi_wsc = 0.4 params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.overrideCE = 160
    params.overrideVE = 480

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.RANGED, tpz.aftermath.type.RELIC)
    end

    return tpHits, extraHits, criticalHit, damage
end
