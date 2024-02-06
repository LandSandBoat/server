-----------------------------------
-- Red Lotus Blade
-- Sword weapon skill
-- Skill Level: 50
-- Deals fire elemental damage to enemy. Damage varies with TP.
-- Aligned with the Flame Gorget & Breeze Gorget.
-- Aligned with the Flame Belt & Breeze Belt.
-- Element: Fire
-- Modifiers: STR:40%  INT:40%
-- 100%TP    200%TP    300%TP
-- 1.00      2.38      3.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 1.0, 2.38, 3.0 }
    params.str_wsc = 0.3 params.int_wsc = 0.2
    params.ele = xi.element.FIRE
    params.skill = xi.skill.SWORD
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.0, 2.38, 3.75 }
        params.str_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
