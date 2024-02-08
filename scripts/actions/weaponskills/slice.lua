-----------------------------------
-- Slice
-- Scythe weapon skill
-- Skill level: 5
-- Delivers a single-hit attack. Damage varies with TP.
-- Modifiers: STR:100%
-- 100%TP     200%TP     300%TP
-- 1.50     1.75    2.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.5, 1.75, 2.0 }
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
