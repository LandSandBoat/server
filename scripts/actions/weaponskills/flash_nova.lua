-----------------------------------
-- Flash Nova
-- Skill level: 290
-- Delivers light elemental damage. Additional effect: Flash. Chance of effect varies with TP.
-- Generates a significant amount of Enmity.
-- Does not stack with Sneak Attack
-- Aligned with Aqua Gorget.
-- Aligned with Aqua Belt.
-- Properties:
-- Element: Light
-- Skillchain Properties:Induration Reverberation
-- Modifiers: STR:30% MND:30%
-- Damage Multipliers by TP:
--     100%TP    200%TP     300%TP
--      3.00     3.00     3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 3.0, 3.0, 3.0 }
    params.str_wsc = 0.3 params.mnd_wsc = 0.3
    params.ele = xi.element.LIGHT
    params.skill = xi.skill.CLUB
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.5 params.mnd_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
