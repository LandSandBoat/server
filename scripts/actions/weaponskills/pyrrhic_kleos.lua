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
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 1.5, 1.5, 1.5 }
    params.str_wsc = 0.2 params.dex_wsc = 0.3

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/15896.html
        params.ftpMod = { 1.75, 1.75, 1.75 }
        params.str_wsc = 0.4 params.dex_wsc = 0.4
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    if damage > 0 then
        if not target:hasStatusEffect(xi.effect.EVASION_DOWN) then
            local duration = tp / 1000 * 60 * applyResistanceAddEffect(player, target, xi.element.ICE, 0)
            target:addStatusEffect(xi.effect.EVASION_DOWN, 10, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
