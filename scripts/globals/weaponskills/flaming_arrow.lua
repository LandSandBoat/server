-----------------------------------
-- Flaming Arrow
-- Archery weapon skill
-- Skill level: 5
-- Deals fire elemental damage. Damage varies with TP.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: Fire
-- Modifiers: STR:16%  AGI:25%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.16 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.25 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.hybridWS = true
    params.ele = tpz.magic.ele.FIRE
    params.skill = tpz.skill.ARCHERY

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 0.5 params.ftp200 = 0.75 params.ftp300 = 1
        params.str_wsc = 0.2 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage

end
