-----------------------------------
-- Tachi Yukikaze
-- Great Katana weapon skill
-- Skill Level: 200 (Samurai only.)
-- Blinds target. Damage varies with TP.
-- Blind effect duration is 60 seconds when unresisted.
-- Will stack with Sneak Attack.
-- Tachi: Yukikaze appears to have an attack bonus of 50%. http://www.bg-wiki.com/bg/Tachi:_Yukikaze
-- Aligned with the Snow Gorget & Breeze Gorget.
-- Aligned with the Snow Belt & Breeze Belt.
-- Element: None
-- Modifiers: STR:75%
-- 100%TP    200%TP    300%TP
-- 1.5625    2.6875    4.125
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.5625, 1.88, 2.5 }
    params.str_wsc = 0.75
    params.atkVaries = { 1.33, 1.33, 1.33 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.5625, 2.6875, 4.125 }
        params.atkVaries = { 1.5, 1.5, 1.5 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.BLINDNESS) then
        local duration = 60 * applyResistanceAddEffect(player, target, xi.element.DARK, 0)
        target:addStatusEffect(xi.effect.BLINDNESS, 25, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
