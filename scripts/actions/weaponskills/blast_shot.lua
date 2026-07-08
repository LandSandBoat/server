-----------------------------------
-- Blast Shot
-- Marksmanship weapon skill
-- Skill Level: 200
-- Delivers a melee-distance ranged attack. params.accuracy varies with TP.
-- Aligned with the Snow Gorget & Light Gorget.
-- Aligned with the Snow Belt & Light Belt.
-- Element: None
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 2.00      2.00      2.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.0, 2.0, 2.0 }
    params.agi_wsc = 0.3
    params.accVaries = { 0, 30, 60 } -- TODO: verify exact number

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
