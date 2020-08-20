-----------------------------------
-- Blade Hi
-- Katana weapon skill
-- Skill level: N/A
-- Description: Deals quadruple damage. Chance of params.critical hit varies with TP. Kannagi: Aftermath.
-- Available only when equipped with Kannagi (85)/(90)/(95)/(99) or Tobi +1/+2/+3.
-- Aligned with the Shadow Gorget & Soil Gorget.
-- Aligned with the Shadow Belt & Soil Belt.
-- Element: None
-- Modifiers: AGI:60%
-- Skillchain Properties: Darkness/Gravitation
-- 100%TP    200%TP    300%TP
-- 4.00      4.00      4.00
--
-- params.critical Hit Rate by TP:
-- 100%TP    200%TP    300%TP
-- 15%         20%       25%
--
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 4 params.ftp200 = 4 params.ftp300 = 4
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.6 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.15 params.crit200 = 0.2 params.crit300 = 0.25
    params.canCrit = true
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 5 params.ftp200 = 5 params.ftp300 = 5
        params.agi_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.EMPYREAN)
    end

    return tpHits, extraHits, criticalHit, damage
end
