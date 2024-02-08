-----------------------------------
-- Hot Shot
-- Marksmanship weapon skill
-- Skill Level: 5
-- Deals fire elemental damage to enemy.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: Fire
-- Modifiers: AGI:30%
-- 100%TP    200%TP    300%TP
-- 0.50      0.75      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 0.5, 0.75, 1.0 }
    params.agi_wsc = 0.3
    params.hybridWS = true
    params.ele = xi.element.FIRE
    params.skill = xi.skill.MARKSMANSHIP
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 0.5, 1.55, 2.1 }
        params.agi_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
