-----------------------------------
-- Sickle Moon
-- Great Sword weapon skill
-- Skill level: 200
-- Delivers a two-hit attack. Damage varies with TP.
-- Modifiers: STR:40%  AGI:40%
-- 100%TP     200%TP     300%TP
-- 1.5         2        2.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 1.5, 2.0, 2.75 }
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.2 params.agi_wsc = 0.2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.agi_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
