-----------------------------------
-- Piercing Arrow
-- Archery weapon skill
-- Skill level: 40
-- Ignores enemy's defense. Amount ignored varies with TP.
-- The amount of defense ignored is 0% with 100TP, 35% with 200TP and 50% with 300TP.
-- Typically does less damage than Flaming Arrow.
-- Aligned with the Snow Gorget & Light Gorget.
-- Aligned with the Snow Belt & Light Belt.
-- Element: None
-- Modifiers: STR:20%  AGI:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
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
    -- Defense ignored is 0%, 35%, 50% as per wiki.bluegartr.com
    params.ignoresDef = true
    params.ignored100 = 0
    params.ignored200 = 0.35
    params.ignored300 = 0.5

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.2 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage

end
