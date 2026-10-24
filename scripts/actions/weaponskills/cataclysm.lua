-----------------------------------
-- Cataclysm
-- Staff weapon skill
-- Skill level: 290
-- Delivers an area attack that deals darkness elemental damage. Damage varies with TP.
-- Element: Dark
-- Skillchain Properties: Compression, Reverberation
-- Modifiers: STR:30% INT:30%
-- 100%TP    200%TP    300%TP
-- 1.75      3.75      6.50
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 2.75, 4.0, 5.0 } -- FFO and the July 2014 bug report
    params.str_wsc = 0.3 params.int_wsc = 0.3
    params.ele = xi.element.DARK
    params.skill = xi.skill.STAFF
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.75, 3.75, 6.5 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
