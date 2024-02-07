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
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod = { 3.0, 3.0, 3.0 }
    params.dex_wsc = 0.3
    params.chr_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 5.0, 5.0, 5.0 }
        params.chr_wsc = 0.7
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.WEIGHT) then
        if not target:hasStatusEffect(xi.effect.WEIGHT) then
            if tp - 1000 > math.random() * 150 then
                target:addStatusEffect(xi.effect.WEIGHT, 50, 0, 60)
            end
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
