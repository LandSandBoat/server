-----------------------------------
-- Piercing Arrow
-- Archery weapon skill
-- Skill level: 40
-- Ignores enemy's defense. Amount ignored varies with TP.
-- The amount of defense ignored is 0% with 100TP, 35% with 200TP and 50% with 300TP.
-- Typically does less damage than Flaming Arrow.
-- Aligned with the Snow Gorget & Light Gorget.
-- Aligned with the Snow Belt & Light Belt.
-- Element: None
-- Modifiers: STR:20%  AGI:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.16 params.agi_wsc = 0.25
    -- Defense ignored is 0%, 35%, 50% as per wiki.bluegartr.com
    params.ignoredDefense = { 0.0, 0.35, 0.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.2 params.agi_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
