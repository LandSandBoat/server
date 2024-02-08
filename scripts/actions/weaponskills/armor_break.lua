-----------------------------------
-- Armor Break
-- Great Axe weapon skill
-- Skill level: 100
-- Lowers enemy's defense. Duration of effect varies with TP.
-- Lowers defense by as much as 25% if unresisted.
-- Strong against: Antica, Bats, Cockatrice, Dhalmel, Lizards, Mandragora, Worms.
-- Immune: Ahriman.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Wind
-- Modifiers: STR:20%  VIT:20%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1, 1, 1 }
    params.str_wsc = 0.2 params.vit_wsc = 0.2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.vit_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.DEFENSE_DOWN) then
        local duration = (120 + (tp / 1000 * 60)) * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 25, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
