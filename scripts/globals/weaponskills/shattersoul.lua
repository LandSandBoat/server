-----------------------------------
-- Shattersoul
-- Skill Level: 357
-- Description: Delivers a threefold attack. Decreases target's magic defense. Duration of effect varies with TP.
-- To obtain Shattersoul, the quest Martial Mastery must be completed and it must be purchased from the Merit Points menu.
-- Target's magic defense is lowered by 10.
-- Aligned with the Shadow Gorget, Soil Gorget & Snow Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Snow Belt.
-- Element: N/A
-- Skillchain Properties: Gravitation/Induration
-- Shattersoul is only available to Warriors, Monks, White Mages, Black Mages, Paladins, Bards, Dragoons, Summoners and Scholars.
-- While some jobs may obtain skill level 357 earlier than level 96, Shattersoul must be unlocked once skill reaches level 357 and job level 96 is reached.
-- Staff skill level 357 is obtainable by the following jobs at these corresponding levels:
-- Modifiers: INT:73~85%, depending on merit points upgrades.
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
-- 1.375      1.375      1.375
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 3
    params.ftp100 = 1.375 params.ftp200 = 1.375 params.ftp300 = 1.375
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.85 + (player:getMerit(tpz.merit.SHATTERSOUL) / 100) params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.int_wsc = 0.7 + (player:getMerit(tpz.merit.SHATTERSOUL) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if (damage > 0 and target:hasStatusEffect(tpz.effect.MAGIC_DEF_DOWN) == false) then
        target:addStatusEffect(tpz.effect.MAGIC_DEF_DOWN, 10, 0, 120)
    end
    return tpHits, extraHits, criticalHit, damage

end
