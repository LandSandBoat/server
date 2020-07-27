-----------------------------------
-- Ground Strike
-- Great Sword weapon skill
-- Skill level: 250 QUESTED
-- Delivers a single-hit attack. Damage varies with TP.
-- Modifiers: STR:50% INT:50%
-- 100%TP     200%TP     300%TP
-- 1.5         1.75    3.0
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function
    params.ftp100 = 1.5 params.ftp200 = 1.75 params.ftp300 = 3.0
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.5 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.5 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    -- critical mods, again in % (ONLY USE FOR CRITICAL HIT VARIES WITH TP)
    params.crit100 = 0.0 params.crit200=0.0 params.crit300=0.0
    params.canCrit = false
    -- accuracy mods (ONLY USE FOR ACCURACY VARIES WITH TP) , should be the params.acc at those %s NOT the penalty values. Leave 0 if params.acc doesnt vary with tp.
    params.acc100 = 0 params.acc200=0 params.acc300=0
    -- attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
    params.atk100 = 1.75; params.atk200 = 1.75; params.atk300 = 1.75

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end
