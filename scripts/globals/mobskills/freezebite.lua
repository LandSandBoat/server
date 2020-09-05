-----------------------------------
-- Freezebite
-- Great Sword weapon skill
-- Skill Level: 100
-- Delivers an ice elemental attack. Damage varies with TP.
-- Aligned with the Snow Gorget & Breeze Gorget.
-- Aligned with the Snow Belt & Breeze Belt.
-- Element: Ice
-- Modifiers: STR:30%  INT:20%
-- 100%TP    200%TP    300%TP
-- 1.00      1.50      3.00
-----------------------------------

require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
require("scripts/globals/monstertpmoves")
-----------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1.5 params.ftp300 = 3
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.2 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(mob, target, 0, params, 0, nil, true, nil)

    target:takeDamage(damage, mob, tpz.attackType.MAGICAL, tpz.damageType.ICE)
    return damage
end
