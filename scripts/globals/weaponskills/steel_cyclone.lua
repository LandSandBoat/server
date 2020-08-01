-----------------------------------
-- Steel Cyclone
-- Great Axe weapon skill
-- Skill level: 240
-- Delivers a single-hit attack. Damage varies with TP.
-- In order to obtain Steel Cyclone, the quest The Weight of Your Limits must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Aqua Belt & Snow Belt.
-- Element: None
-- Modifiers: STR:60%  VIT:60%
-- 100%TP    200%TP    300%TP
-- 1.50       2.5       4.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.5 params.ftp200 = 1.75 params.ftp300 = 3
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.5 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.66; params.atk200 = 1.66; params.atk300 = 1.66

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp200 = 2.5 params.ftp300 = 4
        params.str_wsc = 0.6 params.vit_wsc = 0.6
        params.atk100 = 1.5; params.atk200 = 1.5; params.atk300 = 1.5
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
