-----------------------------------
-- Sonic Thrust
-- Polearm weapon skill
-- Skill Level: 300
-- Delivers an area attack. Damage varies with TP.
-- Will stack with Sneak Attack.
-- Element: None
-- Modifiers: STR:40%  DEX:40%
-- 100%TP    200%TP    300%TP
-- 3.00       3.7       4.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.0, 3.25, 3.5 }
    params.str_wsc = 0.3 params.dex_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.0, 3.7, 4.5 }
        params.str_wsc = 0.4 params.dex_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
