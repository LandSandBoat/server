-----------------------------------
-- Detonator
-- Marksmanship weapon skill
-- Skill Level: 250
-- Delivers a single-hit attack. Damage varies with TP.
-- In order to obtain Detonator, the quest Shoot First, Ask Questions Later must be completed.
-- Despite the lack of a STR weaponskill mod, STR is still the most potent stat for increasing this weaponskill's damage to the point at which fSTR2 is capped.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 1.50      2.00      2.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.5, 2.0, 2.5 }
    params.agi_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.5, 2.5, 5.0 }
        params.agi_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
