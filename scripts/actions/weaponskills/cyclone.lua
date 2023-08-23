-----------------------------------
-- Cyclone
-- Dagger weapon skill
-- Skill level: 125
-- Delivers an area attack that deals wind elemental damage. Damage varies with TP.
-- This weapon skill is ranged and can be used from a distance (Up to 15').
-- Directly affected by Magic Attack Bonus.
-- Aligned with the Breeze Gorget & Thunder Gorget.
-- Aligned with the Breeze Belt & Thunder Belt.
-- Element: Wind
-- Modifiers: DEX:30%  INT:25%
-- 100%TP    200%TP    300%TP
-- 1.00      2.38      2.88
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1 params.ftp200 = 2.375 params.ftp300 = 2.875
    params.str_wsc = 0.0 params.dex_wsc = 0.3 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.25 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = xi.element.WIND
    params.skill = xi.skill.DAGGER
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.4 params.int_wsc = 0.4
        params.ftp300 = 3.75 -- http://wiki.ffo.jp/html/685.html
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
