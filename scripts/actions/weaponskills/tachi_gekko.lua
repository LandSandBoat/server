-----------------------------------
-- Tachi Gekko
-- Great Katana weapon skill
-- Skill Level: 225
-- Silences target. Damage varies with TP.
-- Silence effect duration is 60 seconds when unresisted.
-- Will stack with Sneak Attack.
-- Tachi: Gekko has a high attack bonus of +100%. [1]
-- Aligned with the Aqua Gorget & Snow Gorget.
-- Aligned with the Aqua Belt & Snow Belt.
-- Element: None
-- Modifiers: STR:75%
-- 100%TP    200%TP    300%TP
-- 1.5625      2.6875      4.125
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.5625, 1.88, 2.5 }
    params.str_wsc = 0.75
    params.atkVaries = { 2.0, 2.0, 2.0 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 1.5625, 2.6875, 4.125 }
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Silence duration changed from 60 to 45 as per bg-wiki: http://www.bg-wiki.com/bg/Tachi:_Gekko
    if damage > 0 and not target:hasStatusEffect(xi.effect.SILENCE) then
        local duration = 60 * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.SILENCE, 1, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
