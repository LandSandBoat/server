-----------------------------------
-- Apex Arrow
-- Archery weapon skill
-- Skill level: 357
-- Merit
-- RNG or SAM
-- Aligned with the Thunder & Light Gorget.
-- Aligned with the Thunder Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:73~85%
-- 100%TP    200%TP    300%TP
-- 3.00      3.00      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3, 3, 3 }
    params.agi_wsc = player:getMerit(xi.merit.APEX_ARROW) * 0.17
    params.ignoredDefense = { 0.15, 0.35, 0.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 0.7 + (player:getMerit(xi.merit.APEX_ARROW) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
