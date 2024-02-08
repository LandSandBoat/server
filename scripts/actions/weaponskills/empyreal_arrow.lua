-----------------------------------
-- Empyreal Arrow
-- Archery weapon skill
-- Skill level: 250
-- In order to obtain Empyreal Arrow, the quest From Saplings Grow must be completed.
-- Delivers a single-hit attack. Damage varies with TP.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: STR:16%  AGI:25%
-- 100%TP    200%TP    300%TP
-- 2.00      2.75      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.0, 2.75, 3.0 }
    params.str_wsc = 0.16 params.agi_wsc = 0.25

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.5, 2.5, 5.0 }
        params.str_wsc = 0.20 params.agi_wsc = 0.50
        params.atkVaries = { 2.0, 2.0, 2.0 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
