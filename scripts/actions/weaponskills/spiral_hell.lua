-----------------------------------
-- Spiral Hell
-- Scythe weapon skill
-- Skill level: 240 QUESTED
-- Delivers a single-hit attack. Damage varies with TP.
-- Modifiers: STR:50%  INT:50%
-- 100%TP     200%TP     300%TP
-- 1.375     2.75     4.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.375, 1.875, 3.625 }
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.5 params.int_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.375, 2.75, 4.75 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
