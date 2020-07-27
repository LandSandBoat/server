-----------------------------------
-- Coronach
-- Skill Level: N/A
-- Description: Additional effect: temporarily lowers enmity.
-- Lowers Enmity for a certain amount of time. (Enmity -20)
-- Regardless of the damage, Coronach hate is only 80CE / 240 VE (Enmity- effect included).
-- This weapon skill is only available with the stage 5 relic Gun Annihilator, within Dynamis with the stage 4 Ferdinand or under the latent effect of Exequy Gun.
-- Aligned with the Breeze Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt & Thunder Belt.
-- Properties
-- Element: None
-- Skillchain Properties: Darkness/Fragmentation
-- Modifiers: DEX:40%  AGI:40%
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
--  3.00    3.00    3.00
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 3 params.ftp200 = 3 params.ftp300 = 3
    params.str_wsc = 0.0 params.dex_wsc = 0.4 params.vit_wsc = 0.0
    params.agi_wsc = 0.4 params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.overrideCE = 80
    params.overrideVE = 240

    local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.RANGED, tpz.aftermath.type.RELIC)
    end

    return tpHits, extraHits, criticalHit, damage
end
