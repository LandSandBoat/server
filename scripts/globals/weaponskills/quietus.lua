-----------------------------------
-- Quietus
-- Scythe weapon skill
-- Skill Level: N/A
-- Delivers a triple damage attack that ignores target's defense. Amount ignored varies with TP. Redemption: Aftermath.
-- Available only when equipped with Redemption (85)/(90)/(95)/(99) or Penitence +1/+2/+3/Umiliati.
-- Aligned with the Shadow Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Shadow Belt, Aqua Belt & Snow Belt.
-- Element: None
-- Modifiers: STR: 60% MND: 60%
-- 100%TP    200%TP    300%TP
-- 3.00        3.00      3.00
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 3.0 params.ftp200 = 3.0 params.ftp300 = 3.0
    params.str_wsc = 0.4 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.4 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.ignoresDef = true
    params.ignored100 = 0.1
    params.ignored200 = 0.3
    params.ignored300 = 0.5

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.mnd_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.EMPYREAN)
    end

    return tpHits, extraHits, criticalHit, damage
end
