-----------------------------------
-- Upheaval
-- Great Axe weapon skill
-- Skill Level: 357
-- Delivers a four-hit attack. Damage varies with TP.
-- In order to obtain Upheaval, the quest Martial Mastery must be completed.
-- Aligned with Flame Gorget, Light Gorget & Shadow Gorget.
-- Aligned with Flame Belt, Light Belt & Shadow Belt.
-- Element: None
-- Modifiers: VIT: 73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.00        3.50       6.5
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 4
    params.ftp100 = 1.0 params.ftp200 = 3.5 params.ftp300 = 6.5
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.85 + (player:getMerit(tpz.merit.UPHEAVAL) / 100) params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = true
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.vit_wsc = 0.7 + (player:getMerit(tpz.merit.UPHEAVAL) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
