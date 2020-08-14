-----------------------------------
-- Entropy
-- Scythe weapon skill
-- Skill level: 357
-- Description: Delivers a fourfold attack that converts damage dealt into own MP. Damage varies with TP.
-- In order to obtain Entropy, the quest Martial Mastery must be completed.
-- MP recovery is about 15~25% of damage dealt.
-- Aligned with the Shadow Gorget, Soil Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt, Soil Belt & Aqua Belt.
-- Element: None
-- Modifiers: INT:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 0.75       1.25       2.0
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 4
    params.ftp100 = 0.75 params.ftp200 = 1.25 params.ftp300 = 2.0
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.85 + (player:getMerit(tpz.merit.ENTROPY) / 100) params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.int_wsc = 0.7 + (player:getMerit(tpz.merit.ENTROPY) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    player:addMP(damage * 0.2)
    return tpHits, extraHits, criticalHit, damage

end
