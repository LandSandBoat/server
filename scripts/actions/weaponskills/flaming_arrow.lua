-----------------------------------
-- Flaming Arrow
-- Archery weapon skill
-- Skill level: 5
-- Deals fire elemental damage. Damage varies with TP.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: Fire
-- Modifiers: STR:16%  AGI:25%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.16 params.agi_wsc = 0.25
    params.hybridWS = true
    params.ele = xi.element.FIRE
    params.skill = xi.skill.ARCHERY
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 0.5, 0.75, 1.0 }
        params.str_wsc = 0.2 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
