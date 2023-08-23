-----------------------------------
-- Gust Slash
-- Dagger weapon skill
-- Skill level: 40
-- Deals wind elemental damage. Damage varies with TP.
-- Will not stack with Sneak Attack.
-- Aligned with the Breeze Gorget.
-- Aligned with the Breeze Belt.
-- Element: Wind
-- Modifiers: DEX:20%  INT:20%
-- 100%TP    200%TP    300%TP
-- 1.00      2.00      2.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftp100 = 1 params.ftp200 = 2 params.ftp300 = 2.5
    params.str_wsc = 0.0 params.dex_wsc = 0.2 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.2 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = xi.element.WIND
    params.skill = xi.skill.DAGGER
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.4 params.int_wsc = 0.4
        params.ftp300 = 3 -- http://wiki.ffo.jp/html/682.html
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
