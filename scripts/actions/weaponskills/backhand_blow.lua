-----------------------------------
-- Backhand Blow
-- Hand-to-Hand weapon skill
-- Skill Level: 100
-- Deals params.critical damage. Chance of params.critical hit varies with TP.
-- Aligned with the Breeze Gorget.
-- Aligned with the Breeze Belt.
-- Element: None
-- Modifiers: STR:30%  DEX:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1, 1, 1 }
    params.str_wsc = 0.3 params.dex_wsc = 0.3
    params.critVaries = { 0.4, 0.6, 0.8 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/2419.html
        params.str_wsc = 0.5 params.dex_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
