-----------------------------------
-- Rampage
-- Axe weapon skill
-- Skill level: 175
-- Delivers a five-hit attack. Chance of params.critical varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Soil Gorget.
-- Aligned with the Soil Belt.
-- Element: None
-- Modifiers: STR:50%
-- 100%TP    200%TP    300%TP
--   1         1         1
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftp100 = 0.5 params.ftp200 = 0.5 params.ftp300 = 0.5
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0
    params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.10 params.crit200 = 0.30 params.crit300 = 0.50
    params.canCrit = true
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1.0 params.atk200 = 1.0 params.atk300 = 1.0

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
        params.str_wsc = 0.5
        params.crit100 = 0.0 params.crit200 = 0.20 params.crit300 = 0.40
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
