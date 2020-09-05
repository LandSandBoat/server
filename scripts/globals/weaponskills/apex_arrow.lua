-----------------------------------
-- Apex Arrow
-- Archery weapon skill
-- Skill level: 357
-- Merit
-- RNG or SAM
-- Aligned with the Thunder & Light Gorget.
-- Aligned with the Thunder Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:73~85%
-- 100%TP    200%TP    300%TP
-- 3.00      3.00      3.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 3 params.ftp200 = 3 params.ftp300 = 3
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0
    params.agi_wsc = 0.85 + (player:getMerit(tpz.merit.APEX_ARROW) / 100) params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.ignoresDef = true
    params.ignored100 = 0.15
    params.ignored200 = 0.35
    params.ignored300 = 0.5

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.agi_wsc = 0.7 + (player:getMerit(tpz.merit.APEX_ARROW) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage

end
