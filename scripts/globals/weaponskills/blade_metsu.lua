-----------------------------------
-- Blade Metsu
-- Katana weapon skill
-- Skill Level: N/A
-- Additional effect: Paralysis
-- Hidden effect: temporarily enhances Subtle Blow xi.effect.
-- One hit weapon skill, despite non single-hit animation.
-- This weapon skill is only available with the stage 5 relic Katana Kikoku or within Dynamis with the stage 4 Yoshimitsu.
-- Weaponskill is also available with the Sekirei Katana obtained from Abyssea NM Sedna.
-- Aligned with the Shadow Gorget, Breeze Gorget & Thunder Gorget.
-- Aligned with the Shadow Belt, Breeze Belt & Thunder Belt.
-- Element: None
-- Modifiers: DEX:60%
-- 100%TP    200%TP    300%TP
-- 3.00      3.00      3.00
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 3 params.ftp200 = 3 params.ftp300 = 3
    params.str_wsc = 0.0 params.dex_wsc = 0.6 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 1 params.acc200 = 1 params.acc300 = 1
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    local effectParams = {}
    effectParams.element = xi.magic.ele.ICE
    effectParams.effect = xi.effect.PARALYSIS
    effectParams.skillType = xi.skill.KATANA
    effectParams.duration = 60
    effectParams.power = 10
    effectParams.tick = 0
    effectParams.maccBonus = 0

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 then
        xi.magic.applyAbilityResistance(player, target, effectParams)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
