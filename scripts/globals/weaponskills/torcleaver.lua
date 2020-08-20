-----------------------------------
-- Torcleaver
-- Skill Level: N/A
-- Description: Deals triple damage. Damage varies with TP. Caladbolg: Aftermath.
-- Available only when equipped with Caladbolg (85)/(90)/(95) or Espafut +1/+2/+3.
-- Aligned with the Light Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Light Belt, Aqua Belt & Snow Belt.
-- Element: None
-- Skillchain Properties: Light/Distortion
-- Modifiers: VIT:60%
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
-- 4.75        5.75    6.5
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 4.75 params.ftp200 = 5.75 params.ftp300 = 6.5
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.6 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.00 params.crit200 = 0.00 params.crit300 = 0.00
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 4.75 params.ftp200 = 7.5 params.ftp300 = 10
        params.vit_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.EMPYREAN)
    end

    return tpHits, extraHits, criticalHit, damage
end
