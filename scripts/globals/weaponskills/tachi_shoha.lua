-----------------------------------
-- Tachi: Shoha
-- Great Katana weapon skill
-- Skill Level: 357
-- Delivers a two-hit attack. Damage varies with TP.
-- To obtain Tachi: Shoha, the quest Martial Mastery must be completed and it must be purchased from the Merit Points menu.
-- Suspected to have an Attack Bonus similar to Tachi: Yukikaze, Tachi: Gekko, and Tachi: Kasha, but only on the first hit.
-- Aligned with the Breeze Gorget, Thunder Gorget & Shadow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Shadow Belt.
-- Element: None
-- Modifiers: STR:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.375     2.1875      2.6875
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 2
    params.ftp100 = 1.375 params.ftp200 = 2.1875 params.ftp300 = 2.6875
    params.str_wsc = 0.85 + (player:getMerit(tpz.merit.TACHI_SHOHA) / 100) params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.375; params.atk200 = 1.375; params.atk300 = 1.375

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.7 + (player:getMerit(tpz.merit.TACHI_SHOHA) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
