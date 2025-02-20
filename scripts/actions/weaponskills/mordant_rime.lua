-----------------------------------
-- Mordant Rime
-- Dagger weapon skill
-- Skill level: N/A
-- Description: Delivers a twofold attack that decreases target's movement speed. Chance of decreasing movement speed varies with TP. Carnwenhan: Aftermath effect varies with TP.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.
-- Element: None
-- Skillchain Properties: Fragmentation/Distortion
-- Modifiers: DEX:30%  CHR:70%
-- Damage Multipliers by TP:
-- 100%TP    200%TP    300%TP
-- 5.0        5.0        5.0
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 3, 3, 3 }
    params.dex_wsc = 0.3
    params.chr_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod  = { 5, 5, 5 }
        params.chr_wsc = 0.7
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    if math.random(1, 100) <= tp / 30 * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) then
        local effectId      = xi.effect.WEIGHT
        local actionElement = xi.element.WIND
        local power         = 25
        local duration      = math.floor(60 * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
