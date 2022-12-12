-----------------------------------
-- Shining Strike
-- Club weapon skill
-- Skill level: 5
-- Deals light elemental damage to enemy. Damage varies with TP.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: None
-- Modifiers: STR:40%  MND:40%
-- 100%TP    200%TP    300%TP
-- 1.625       3       4.625
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1 params.ftp200 = 1.75 params.ftp300 = 2.5
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.2 params.chr_wsc = 0.0
    params.ele = xi.magic.ele.LIGHT
    params.skill = xi.skill.CLUB
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 1.625 params.ftp200 = 3 params.ftp300 = 4.625
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
