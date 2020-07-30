-----------------------------------
-- Dancing Edge
-- Dagger weapon skill
-- Skill level: 200
-- Delivers a fivefold attack. params.accuracy varies with TP.
-- Will stack with Sneak Attack.
-- Will stack with Trick Attack.
-- Aligned with the Breeze Gorget & Soil Gorget.
-- Aligned with the Breeze Belt & Soil Belt.
-- Element: None
-- Modifiers: DEX:30%  CHR:40%
-- 100%TP    200%TP    300%TP
-- 1.19      1.19      1.19
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 5
    params.ftp100 = 1.1875 params.ftp200 = 1.1875 params.ftp300 = 1.1875
    params.str_wsc = 0.0 params.dex_wsc = 0.3 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.4
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.8 params.acc200= 0.9 params.acc300= 1
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.dex_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
