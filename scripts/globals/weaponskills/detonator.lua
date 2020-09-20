-----------------------------------
-- Detonator
-- Marksmanship weapon skill
-- Skill Level: 250
-- Delivers a single-hit attack. Damage varies with TP.
-- In order to obtain Detonator, the quest Shoot First, Ask Questions Later must be completed.
-- Despite the lack of a STR weaponskill mod, STR is still the most potent stat for increasing this weaponskill's damage to the point at which fSTR2 is capped.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 1.50      2.00      2.50
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.5 params.ftp200 = 2 params.ftp300 = 2.5
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.3 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 1.5 params.ftp200 = 2.5 params.ftp300 = 5.0
        params.agi_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage

end
