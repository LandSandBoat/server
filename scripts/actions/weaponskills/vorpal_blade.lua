-----------------------------------
-- Vorpal Blade
-- Sword weapon skill
-- Skill Level: 200
-- Delivers a four-hit attack. Chance of params.critical varies with TP.
-- Stacks with Sneak Attack.
-- Aligned with the Soil Gorget & Thunder Gorget.
-- Aligned with the Soil Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR:60%
-- 100%TP    200%TP    300%TP
-- 1.375      1.375      1.375
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3
    params.critVaries = { 0.1, 0.3, 0.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.375, 1.375, 1.375 }
        params.str_wsc = 0.6
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
