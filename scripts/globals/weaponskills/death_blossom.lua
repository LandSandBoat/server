-----------------------------------
-- Death Blossom
-- Sword weapon skill (RDM main only)
-- Description: Delivers a threefold attack that lowers target's magic evasion. Chance of lowering target's magic evasion varies with TP. Murgleis: Aftermath effect varies with TP.
-- Lowers magic evasion by up to 10.
-- Effect lasts up to 55 seconds.
-- Available only after completing the Unlocking a Myth (Red Mage) quest.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.
-- Modifiers: STR:30%  MND:50%
-- 100%TP     200%TP      300%TP
--  4              4           4        new
-- 1.125      1.125      1.125        old
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    -- ftp damage mods (for Damage Varies with TP lines are calculated in the function
    params.ftp100 = 1.125 params.ftp200 = 1.125 params.ftp300 = 1.125
    -- wscs are in % so 0.2=20%
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.5 params.chr_wsc = 0.0
    -- critical mods, again in % (ONLY USE FOR critICAL HIT VARIES WITH TP)
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    -- accuracy mods (ONLY USE FOR accURACY VARIES WITH TP) , should be the acc at those %s NOT the penalty values. Leave 0 if acc doesnt vary with tp.
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    -- attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 4.0 params.ftp200 = 4.0 params.ftp300 = 4.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    if damage > 0 then
        local duration = tp / 1000 * 20 - 5
        if not target:hasStatusEffect(tpz.effect.MAGIC_EVASION_DOWN) then
            target:addStatusEffect(tpz.effect.MAGIC_EVASION_DOWN, 10, 0, duration)
        end

        -- Apply aftermath
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.MAIN, tpz.aftermath.type.MYTHIC)
    end

    return tpHits, extraHits, criticalHit, damage
end
