-----------------------------------
-- Resolution
-- Great Sword weapon skill
-- Skill Level: 357
-- Delivers a fivefold attack. Damage varies with TP.
-- In order to obtain Resolution, the quest Martial Mastery must be completed.
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits.
-- Resolution has an attack penalty of -8%.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 0.71875    1.5       2.25
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 5
    params.ftp100 = 0.71875 params.ftp200 = 0.84375 params.ftp300 = 0.96875
    params.str_wsc = 0.85 + (player:getMerit(tpz.merit.RESOLUTION) / 100) params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 0.85; params.atk200 = 0.85; params.atk300 = 0.85
    params.multiHitfTP = true

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 0.71875 params.ftp200 = 1.5 params.ftp300 = 2.25
        params.str_wsc = 0.7 + (player:getMerit(tpz.merit.RESOLUTION) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
