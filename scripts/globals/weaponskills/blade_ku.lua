-----------------------------------
-- Blade Ku
-- Katana weapon skill
-- Skill level: N/A
-- Description: Delivers a five-hit attack. params.accuracy varies with TP.
-- In order to obtain Blade: Ku, the quest Bugi Soden must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Shadow Gorget, Soil Gorget & Light Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Light Belt.
-- Skillchain Properties: Gravitation/Transfixion
-- Modifiers: STR:10%  DEX:10%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
--
--         params.acc
-- 100%TP    200%TP    300%TP
-- ??        ??        ??
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 5
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.1 params.dex_wsc = 0.1 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.8 params.acc200= 0.9 params.acc300= 1.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 1.25 params.ftp200 = 1.25 params.ftp300 = 1.25
        params.str_wsc = 0.3 params.dex_wsc = 0.3
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
