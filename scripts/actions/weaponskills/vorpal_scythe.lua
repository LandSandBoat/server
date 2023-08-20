-----------------------------------
-- Vorpal Scythe
-- Scythe weapon skill
-- Skill level: 150
-- Delivers a single-hit attack. params.crit varies with TP.
-- Modifiers: STR:100%
-- 100%TP     200%TP     300%TP
-- 1.0         1.0        1.0
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function
    params.ftp100 = 1.0 params.ftp200 = 1.0 params.ftp300 = 1.0
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.35 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    -- critical mods, again in % (ONLY USE FOR critICAL HIT VARIES WITH TP)
    params.crit100 = 0.3 params.crit200 = 0.6 params.crit300 = 0.9
    params.canCrit = true
    -- accuracy mods (ONLY USE FOR accURACY VARIES WITH TP) , should be the acc at those %s NOT the penalty values. Leave 0 if acc doesnt vary with tp.
    params.acc100 = 0 params.acc200 = 0 params.acc300 = 0
    -- attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
