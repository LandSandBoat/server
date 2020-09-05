-----------------------------------
-- Stardiver
-- Polearm weapon skill
-- Skill Level: MERIT
-- Delivers a fourfold attack. Damage varies with TP.
-- Will stack with Sneak Attack.     reduces params.crit hit evasion by 5%
-- Element: None
-- Modifiers: STR:73~85%
-- 100%TP    200%TP    300%TP
-- 0.75         1.25       1.75
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 4
    params.ftp100 = 0.75 params.ftp200 = 1.25 params.ftp300 = 1.75
    params.str_wsc = 0.85 + (player:getMerit(tpz.merit.STARDIVER) / 100) params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.7 + (player:getMerit(tpz.merit.STARDIVER) / 100)
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if (damage > 0 and target:hasStatusEffect(tpz.effect.CRIT_HIT_EVASION_DOWN) == false) then
        target:addStatusEffect(tpz.effect.CRIT_HIT_EVASION_DOWN, 5, 0, 60)
    end
    return tpHits, extraHits, criticalHit, damage

end
