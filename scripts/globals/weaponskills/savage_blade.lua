-----------------------------------
-- Savage Blade
-- Sword weapon skill
-- Skill Level: 240
-- Delivers an aerial attack comprised of two hits. Damage varies with TP.
-- In order to obtain Savage Blade, the quest Old Wounds must be completed.
-- Will stack with Sneak Attack.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Element: None
-- Modifiers: STR:50%  MND:50%
-- 100%TP    200%TP    300%TP
-- 4.00      10.25      13.75
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 2
    params.ftp100 = 1 params.ftp200 = 1.75 params.ftp300 = 3.5
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 4 params.ftp200 = 10.25 params.ftp300 = 13.75
        params.str_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
