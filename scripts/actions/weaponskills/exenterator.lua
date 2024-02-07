-----------------------------------
-- Exenterator
-- Skill level: 357
-- Terpsichore: Aftermath effect varies with TP.
-- In order to obtain Exenterator, the quest Martial Mastery must be completed.
-- Description: Delivers a fourfold attack that lowers enemy's params.accuracy. Effect duration varies with TP.
-- Aligned with the Breeze Gorget, Thunder Gorget & Soil Gorget.
-- Aligned with the Breeze Belt, Thunder Belt & Soil Belt.
-- Notes: Stacks with itself allowing continuous params.acc down
-- params.acc down isn't the same as the spell Blind or sources which are the same as blind allowing both to stack
-- Element: None
-- Modifiers: AGI:73~85%, depending on merit points upgrades.
-- 100%TP    200%TP    300%TP
-- 1.0        1.0       1.0
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.agi_wsc = player:getMerit(xi.merit.EXENTERATOR) * 0.17

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true
        params.agi_wsc = 0.7 + (player:getMerit(xi.merit.EXENTERATOR) * 0.03)
        params.ftpMod = { 1.1875, 1.1875, 1.1875 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.ACCURACY_DOWN) then
        local duration = (45 + (tp / 1000 * 45)) * applyResistanceAddEffect(player, target, xi.element.EARTH, 0)
        target:addStatusEffect(xi.effect.ACCURACY_DOWN, 20, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
