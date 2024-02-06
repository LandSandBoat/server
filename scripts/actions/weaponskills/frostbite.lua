-----------------------------------
-- Frostbite
-- Great Sword weapon skill
-- Skill Level: 70
-- Delivers an ice elemental attack. Damage varies with TP.
-- Aligned with the Snow Gorget.
-- Aligned with the Snow Belt.
-- Element: Ice
-- Modifiers: STR:20%  INT:20%
-- 100%TP    200%TP    300%TP
-- 1.00      2.00      2.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 1.0, 2.0, 2.5 }
    params.str_wsc = 0.2 params.int_wsc = 0.2
    params.ele = xi.element.ICE
    params.skill = xi.skill.GREAT_SWORD
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
