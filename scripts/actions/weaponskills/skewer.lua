-----------------------------------
-- Skewer
-- Polearm weapon skill
-- Skill Level: 200
-- Delivers a three-hit attack. Chance of params.critical hit varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Light Gorget & Thunder Gorget.
-- Aligned with the Light Belt & Thunder Belt.
-- Element: None
-- Modifiers: STR:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.35
    params.critVaries = { 0.1, 0.3, 0.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
