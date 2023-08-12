-----------------------------------
-- Wildfire
-- Skill Level: N/A
-- Description: Deals fire elemental damage. Enmity generation varies with TP. Armageddon: Aftermath.
-- Acquired permanently by completing the appropriate Walk of Echoes Weapon Skill Trials.
-- Can also be used by equipping Armageddon (85)/(90)/(95)/(99) or Bedlam +1/+2/+3.
-- Aligned with the Soil Gorget & Shadow Gorget.
-- Aligned with the Soil Belt & Shadow Belt.
-- Element: Fire
-- Skillchain Properties: Darkness/Gravitation
-- Modifiers: AGI:60%
-- Damage Multipliers by TP:
--  100%TP    200%TP    300%TP
--  5.5      5.5     5.5
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/magic")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 5.5 params.ftp200 = 5.5 params.ftp300 = 5.5
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0
    params.agi_wsc = 0.6 params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.ele = xi.magic.ele.FIRE
    params.skill = xi.skill.MARKSMANSHIP
    params.includemab = true

    -- TODO: needs to give enmity down at varying tp percent's that is treated separately than the gear cap of -50% enmity http://www.bg-wiki.com/bg/Wildfire

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.EMPYREAN)

    local damage, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, false, damage
end

return weaponskillObject
