-----------------------------------
-- Blade Yu
-- Katana weapon skill
-- Skill Level: 290
-- Delivers a water elemental attack. Additional effect Poison. Durration varies with TP.
-- Aligned with the Aqua Gorget & Soil Gorget.
-- Aligned with the Aqua Belt & Soil Belt.
-- Element: Water
-- Modifiers: DEX:50%  INT:50%
-- 100%TP    200%TP    300%TP
-- 2.25      2.25      2.25
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 2.25 params.ftp200 = 2.25 params.ftp300 = 2.25
    params.str_wsc = 0.0 params.dex_wsc = 0.28 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.28 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    -- http://wiki.ffo.jp/html/20351.html
    params.ele = xi.magic.ele.WATER
    params.skill = xi.skill.KATANA
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 3 params.ftp200 = 3 params.ftp300 = 3
        params.dex_wsc = 0.4 params.int_wsc = 0.4
    end

    local damage, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if damage > 0 and not target:hasStatusEffect(xi.effect.POISON) then
        local duration = (75 + (tp / 1000 * 15)) * applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0)
        target:addStatusEffect(xi.effect.POISON, 10, 0, duration)
    end

    return tpHits, extraHits, false, damage
end

return weaponskillObject
