-----------------------------------
-- Shining Blade
-- Sword weapon skill
-- Skill Level: 100
-- Deals light elemental damage to enemy. Damage varies with TP.
-- Aligned with the Soil Gorget.
-- Aligned with the Soil Belt.
-- Element: Light
-- Modifiers: STR:40%  MND:40%
-- 100%TP    200%TP    300%TP
-- 1.125      2.222      3.523
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 2.0, 2.5 }
    params.str_wsc = 0.2 params.mnd_wsc = 0.2
    params.ele = xi.element.LIGHT
    params.skill = xi.skill.SWORD
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.125, 2.222, 3.523 }
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
