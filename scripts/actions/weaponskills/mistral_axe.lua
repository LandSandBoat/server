-----------------------------------
-- Mistral Axe
-- Axe weapon skill
-- Skill level: 225 (Beastmasters and Warriors only.)
-- Delivers a single-hit ranged attack at a maximum distance of 15.7'. Damage varies with TP.
-- Despite being able to be used from a distance it is considered a melee attack and can be stacked with Sneak Attack and/or Trick Attack
-- Aligned with the Flame Gorget & Light Gorget.
-- Aligned with the Flame Belt & Light Belt.
-- Element: None
-- Modifiers: STR:50%
-- 100%TP    200%TP    300%TP
-- 2.50      3.00      3.50
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.5, 3.0, 3.5 }
    params.str_wsc = 0.5

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 4.0, 10.5, 13.625 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
