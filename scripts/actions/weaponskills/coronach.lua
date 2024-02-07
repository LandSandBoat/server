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
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.0, 3.0, 3.0 }
    params.dex_wsc = 0.4
    params.agi_wsc = 0.4
    params.overrideCE = 80
    params.overrideVE = 240

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Apply aftermath
    if damage > 0 then
        xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.RELIC)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
