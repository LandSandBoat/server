-----------------------------------
-- Blast Arrow
-- Archery weapon skill
-- Skill level: 200
-- Delivers a melee-distance ranged attack. params.accuracy varies with TP.
-- Aligned with the Snow Gorget & Light Gorget.
-- Aligned with the Snow Belt & Light Belt.
-- Element: None
-- Modifiers: STR:16%  AGI:25%
-- 100%TP    200%TP    300%TP
-- 2.00      2.00      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.0, 2.0, 2.0 }
    params.str_wsc = 0.16 params.agi_wsc = 0.25
    params.accVaries = { 0.8, 0.9, 1.0 } -- TODO: verify -- "Accuracy varies with TP" in retail. All current evidence points to that this modifier is static values, not percentages.

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.2 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
