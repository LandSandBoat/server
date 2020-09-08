-----------------------------------
-- Mystic Boon
-- Club weapon skill
-- Skill level: N/A
-- Converts damage dealt to own MP. Damage varies with TP. Yagrush: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (White Mage) quest.
-- Damage is significantly affected by Attack. Verification Needed
-- Not aligned with any "elemental gorgets" or elemental belts due to it's absence of Skillchain properties.
-- Element: None
-- Modifiers: STR:30%  MND:70%
-- 100%TP    200%TP    300%TP
-- 2.5        4.0        7.0
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1.5 params.ftp300 = 2
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 2.5 params.ftp200 = 4 params.ftp300 = 7
        params.mnd_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    player:addMP(damage)

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)
    end

    return tpHits, extraHits, criticalHit, damage
end
