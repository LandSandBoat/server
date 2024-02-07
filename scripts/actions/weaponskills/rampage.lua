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
    params.ftpMod = { 0.5, 0.5, 0.5 }
    params.str_wsc = 0.3
    params.critVaries = { 0.10, 0.30, 0.50 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.0, 1.0, 1.0 }
        params.str_wsc = 0.5
        params.critVaries = { 0.0, 0.20, 0.40 }
        params.multiHitfTP = true
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
