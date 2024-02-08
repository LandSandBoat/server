-----------------------------------
-- Shield Break
-- Great Axe weapon skill
-- Skill level: 5
-- Lowers enemy's Evasion. Duration of effect varies with TP.
-- Lowers Evasion by as much as 40 if unresisted.
-- Strong against: Bees, Beetles, Birds, Crabs, Crawlers, Flies, Lizards, Mandragora, Opo-opo, Pugils, Sabotenders, Scorpions, Sea Monks, Spiders, Tonberry, Yagudo.
-- Immune: Bombs, Gigas, Ghosts, Sheep, Skeletons, Tigers.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Ice
-- Modifiers: STR:60%  VIT:60%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.2 params.vit_wsc = 0.2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.6 params.vit_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.EVASION_DOWN) then
        local duration = (120 + (tp / 1000 * 60)) * applyResistanceAddEffect(player, target, xi.element.ICE, 0)
        target:addStatusEffect(xi.effect.EVASION_DOWN, 40, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
