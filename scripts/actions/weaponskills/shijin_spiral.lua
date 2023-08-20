-----------------------------------
-- Shijin Spiral
-- Hand-to-Hand weapon skill
-- Skill Level: N/A
-- Delivers a fivefold attack that Plagues the target. Chance of inflicting Plague varies with TP.
-- In order to obtain Shijin Spiral, the quest Martial Mastery must be completed.
-- Aligned with the Flame Gorget, Light Gorget & Aqua Gorget.
-- Aligned with the Flame Belt, Light Belt & Aqua Belt.
-- Element: None
-- Modifiers: DEX: 73~85%
-- 100%TP    200%TP    300%TP
-- 1.0625    1.0625    1.0625
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    -- This is a 5 hit ws but H2H ws are done in a different way, the off hand hit is been taking into account in another place
    params.ftp100 = 1.0625 params.ftp200 = 1.0625 params.ftp300 = 1.0625
    params.str_wsc = 0.0 params.dex_wsc = 0.0 + (player:getMerit(xi.merit.SHIJIN_SPIRAL) * 0.17) params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1.05 params.atk200 = 1.05 params.atk300 = 1.05
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/25607.html
        params.ftp100 = 1.5 params.ftp200 = 1.5 params.ftp300 = 1.5
        params.dex_wsc = 0.7 + (player:getMerit(xi.merit.SHIJIN_SPIRAL) * 0.03)
    end

    if damage > 0 then
        local duration = (tp / 1000) + 4
        if not target:hasStatusEffect(xi.effect.PLAGUE) then
            target:addStatusEffect(xi.effect.PLAGUE, 5, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
