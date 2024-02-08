-----------------------------------
-- Rock Crusher
-- Staff weapon skill
-- Skill Level: 40
-- Delivers an earth elemental attack. Damage varies with TP.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Earth
-- Modifiers: STR:40%  INT:40%
-- 100%TP    200%TP    300%TP
-- 1.00      2.00      2.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 1.0, 2.0, 2.5 }
    params.str_wsc = 0.2 params.int_wsc = 0.2
    params.ele = xi.element.EARTH
    params.skill = xi.skill.STAFF
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
