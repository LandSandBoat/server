-----------------------------------
-- Tachi Kasha
-- Great Katana weapon skill
-- Skill Level: 250
-- Paralyzes target. Damage varies with TP.
-- Paralyze effect duration is 60 seconds when unresisted.
-- In order to obtain Tachi: Kasha, the quest The Potential Within must be completed.
-- Will stack with Sneak Attack.
-- Tachi: Kasha appears to have a moderate attack bonus of +50%. [1]
-- Aligned with the Flame Gorget, Light Gorget & Shadow Gorget.
-- Aligned with the Flame Belt, Light Belt & Shadow Belt.
-- Element: None
-- Modifiers: STR:75%
-- 100%TP    200%TP    300%TP
-- 1.5625    2.6875    4.125
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.56, 1.88, 2.5 }
    params.str_wsc = 0.75
    params.atkVaries = { 1.5, 1.5, 1.5 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.5625, 2.6875, 4.125 }
        params.str_wsc = 0.75
        params.atkVaries = { 1.65, 1.65, 1.65 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.PARALYSIS) then
        local duration = 60 * applyResistanceAddEffect(player, target, xi.element.ICE, 0)
        target:addStatusEffect(xi.effect.PARALYSIS, 25, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
