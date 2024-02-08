-----------------------------------
-- Judgment
-- Club weapon skill
-- Were you looking for Judgment Key?
-- Skill level: 200
-- Delivers a single-hit attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: None
-- Modifiers: STR:32%  MND:32%
-- 100%TP    200%TP    300%TP
-- 2.00      2.50      4.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.0, 2.5, 4.0 }
    params.str_wsc = 0.32 params.mnd_wsc = 0.32

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.5, 8.75, 12.0 }
        params.str_wsc = 0.5 params.mnd_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
