-----------------------------------
-- Pyrrhic Kleos
-- Dagger weapon skill
-- Skill level: N/A
-- Description: Delivers a fourfold attack that lowers target's evasion. Duration of effect varies with TP. Terpsichore: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Dancer) quest.
-- Aligned with the Soil Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Soil Belt, Aqua Belt & Snow Belt.
-- Element: Unknown
-- Skillchain Properties: Distortion/Scission
-- Modifiers: STR:40%  DEX:40%
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
-- 1.5        1.5        1.5
-----------------------------------
require("scripts/globals/aftermath")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftp100 = 1.5 params.ftp200 = 1.5 params.ftp300 = 1.5
    params.str_wsc = 0.2 params.dex_wsc = 0.3 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0
    params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/15896.html
        params.ftp100 = 1.75 params.ftp200 = 1.75 params.ftp300 = 1.75
        params.str_wsc = 0.4 params.dex_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    if damage > 0 then
        if not target:hasStatusEffect(xi.effect.EVASION_DOWN) then
            local duration = tp / 1000 * 60 * applyResistanceAddEffect(player, target, xi.magic.ele.ICE, 0)
            target:addStatusEffect(xi.effect.EVASION_DOWN, 10, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
