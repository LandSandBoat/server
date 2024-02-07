-----------------------------------
-- Refulgent Arrow
-- Archery weapon skill
-- Skill level: 290
-- Delivers a twofold attack. Damage varies with TP.
-- Aligned with the Aqua Gorget & Light Gorget.
-- Aligned with the Aqua Belt & Light Belt.
-- Element: None
-- Modifiers: STR: 60% http://www.bg-wiki.com/bg/Refulgent_Arrow
-- 100%TP    200%TP    300%TP
-- 3.00      4.25      7.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 3.0, 4.25, 5.0 }
    params.str_wsc = 0.16

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.0, 4.25, 7.0 }
        params.str_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
