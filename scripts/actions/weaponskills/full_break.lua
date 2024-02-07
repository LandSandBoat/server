-----------------------------------
-- Full Break
-- Great Axe weapon skill
-- Skill level: 225 (Warriors only.)
-- Lowers enemy's attack, defense, params.accuracy, and evasion. Duration of effect varies with TP.
-- Lowers attack and defense by 12.5%, evasion by 20 points, and estimated to also lower params.accuracy by 20 points.
-- These enfeebles are given as four seperate status effects, resists calculated seperately for each. They almost always wear off simultaneously, but have been observed to wear off at different times.
-- Strong against: Coeurls.
-- Immune: Antica, Cockatrice, Crawlers, Worms.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Snow Gorget.
-- Aligned with the Aqua Belt & Snow Belt.
-- Element: Earth
-- Modifiers: STR:50%  VIT:50%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.5 params.vit_wsc = 0.5
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 then
        local duration = (tp / 1000 * 30) + 60

        -- TODO: Table effects, value, and element and loop

        if not target:hasStatusEffect(xi.effect.DEFENSE_DOWN) then
            target:addStatusEffect(xi.effect.DEFENSE_DOWN, 12.5, 0, duration * applyResistanceAddEffect(player, target, xi.element.WIND, 0))
        end

        if not target:hasStatusEffect(xi.effect.ATTACK_DOWN) then
            target:addStatusEffect(xi.effect.ATTACK_DOWN, 12.5, 0, duration * applyResistanceAddEffect(player, target, xi.element.WATER, 0))
        end

        if not target:hasStatusEffect(xi.effect.EVASION_DOWN) then
            target:addStatusEffect(xi.effect.EVASION_DOWN, 20, 0, duration * applyResistanceAddEffect(player, target, xi.element.ICE, 0))
        end

        if not target:hasStatusEffect(xi.effect.ACCURACY_DOWN) then
            target:addStatusEffect(xi.effect.ACCURACY_DOWN, 20, 0, duration * applyResistanceAddEffect(player, target, xi.element.EARTH, 0))
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
