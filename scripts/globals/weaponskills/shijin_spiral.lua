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
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 5
    params.ftp100 = 1.0625 params.ftp200 = 1.0625 params.ftp300 = 1.0625
    params.str_wsc = 0.0 params.dex_wsc = 0.85 + (player:getMerit(tpz.merit.SHIJIN_SPIRAL) / 100) params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1.05; params.atk200 = 1.05; params.atk300 = 1.05
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.dex_wsc = 0.7 + (player:getMerit(tpz.merit.SHIJIN_SPIRAL) / 100)
    end

    if (damage > 0) then
        local duration = (tp/1000) + 4
        if (target:hasStatusEffect(tpz.effect.PLAGUE) == false) then
            target:addStatusEffect(tpz.effect.PLAGUE, 5, 0, duration)
        end
    end
    return tpHits, extraHits, criticalHit, damage

end
