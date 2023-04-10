-----------------------------------
-- Primal Rend
-- Axe weapon skill
-- Skill Level: N/A
-- Deals light elemental damage. Damage varies with TP. Aymur: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Beastmaster) quest.
-- Aligned with the Shadow Gorget, Soil Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Aqua Belt.
-- Element: Light
-- Modifiers: CHR:60% DEX:30%
-- 100%TP    200%TP    300%TP
-- 3.0625    5.8398    7.5625
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 4 params.ftp200 = 4.25 params.ftp300 = 4.75
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.0 params.chr_wsc = 0.3
    params.ele = xi.magic.ele.LIGHT
    params.skill = xi.skill.AXE
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 3.0625 params.ftp200 = 5.8398 params.ftp300 = 7.5625
        params.dex_wsc = 0.3 params.chr_wsc = 0.6
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
