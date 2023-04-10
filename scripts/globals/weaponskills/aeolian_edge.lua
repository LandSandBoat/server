-- Aeolian Edge
-- Dagger weapon skill
-- Delivers an area attack that deals wind elemental damage. Damage varies with TP.
-- Skill Level: 290
-- Aligned with the Breeze Gorget, Soil Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt, Soil Belt & Thunder Belt.
-- Element: Wind
-- Skillchain Properties: Impaction / Scission / Detonation
-- Modifiers: DEX:28% INT:28%
-- 100%TP    200%TP    300%TP
-- 2.75      3.50       4
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2.75 params.ftp200 = 3.50 params.ftp300 = 4
    params.str_wsc = 0.0 params.dex_wsc = 0.28 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.28 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = xi.magic.ele.WIND
    params.skill = xi.skill.DAGGER
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 2 params.ftp200 = 3 params.ftp300 = 4.5 -- https://www.bg-wiki.com/bg/Aeolian_Edge
        params.dex_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
