-----------------------------------
-- Double Thrust
-- Polearm weapon skill
-- Skill Level: 5
-- Delivers a two-hit attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Light Gorget.
-- Aligned with the Light Belt.
-- Element: None
-- Modifiers: STR:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.3
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
