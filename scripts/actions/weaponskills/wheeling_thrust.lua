-----------------------------------
-- Wheeling Thrust
-- Polearm weapon skill
-- Skill Level: 225
-- Ignores enemy's defense. Amount ignored varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: STR:80%
-- 100%TP    200%TP    300%TP
-- 1.75      1.75      1.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.75, 1.75, 1.75 }
    params.str_wsc = 0.5
    -- Defense ignored is 50%, 75%, 100% (50% at 100 TP is accurate, other values are guesses)
    params.ignoredDefense = { 0.5, 0.75, 1.0 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
