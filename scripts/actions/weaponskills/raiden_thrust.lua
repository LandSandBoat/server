-----------------------------------
-- Raiden Thrust
-- Polearm weapon skill
-- Skill Level: 70
-- Deals lightning elemental damage to enemy. Damage varies with TP.
-- Aligned with the Light Gorget & Thunder Gorget.
-- Aligned with the Light Belt & Thunder Belt.
-- Element: Lightning
-- Modifiers: STR:40%  INT:40%
-- 100%TP    200%TP    300%TP
-- 1.00      2.00      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 1.0, 2.0, 3.0 }
    params.str_wsc = 0.3 params.int_wsc = 0.3
    params.ele = xi.element.THUNDER
    params.skill = xi.skill.POLEARM
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
