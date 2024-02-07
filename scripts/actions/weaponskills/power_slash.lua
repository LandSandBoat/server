-----------------------------------
-- Power Slash
-- Great Sword weapon skill
-- Skill level: 30
-- Delivers a single-hit attack. params.crit varies with TP.
-- Modifiers: STR:60%  VIT:60%
-- 100%TP     200%TP     300%TP
-- 1.0         1.0        1.0
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function
    params.ftpMod = { 1.0, 1.0, 1.0 }
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.2 params.vit_wsc = 0.2
    params.critVaries = { 0.2, 0.4, 0.6 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.vit_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
