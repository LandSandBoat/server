-----------------------------------
-- Shark Bite
-- Dagger weapon skill
-- Skill level: 225
-- Delivers a twofold attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Will stack with Trick Attack.
-- Aligned with the Breeze Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt & Thunder Belt.
-- Element: None
-- Modifiers: DEX:40% AGI:40%
-- 100%TP    200%TP    300%TP
--  2.00       4        5.75
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 2
    params.ftp100 = 2 params.ftp200 = 2.5 params.ftp300 = 3
    params.str_wsc = 0.0 params.dex_wsc = 0.5 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 4.5 params.ftp200 = 6.8 params.ftp300 = 8.5
        params.dex_wsc = 0.4 params.agi_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage

end
