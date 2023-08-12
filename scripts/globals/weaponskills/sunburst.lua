-----------------------------------
-- Sunburst
-- Staff weapon skill
-- Skill Level: 150
-- Deals light or darkness elemental damage. Damage varies with TP.
-- Aligned with the Shadow Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt & Aqua Belt.
-- Element: Light/Dark
-- Modifiers: :    STR:40% MND:40%
-- 100%TP    200%TP    300%TP
-- 1.00      2.50      4.00
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1 params.ftp200 = 2.5 params.ftp300 = 4
    params.str_wsc = 0.4 params.dex_wsc = 0.0
    params.vit_wsc = 0.0 params.agi_wsc = 0.0
    params.int_wsc = 0.0 params.mnd_wsc = 0.4
    params.chr_wsc = 0.0
    params.skill = xi.skill.STAFF
    params.includemab = true
    -- 50/50 shot of being light or dark
    params.ele = xi.magic.ele.LIGHT
    if math.random() < 0.5 then
        params.ele = xi.magic.ele.DARK
    end

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.4 params.mnd_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
