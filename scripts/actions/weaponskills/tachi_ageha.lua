-----------------------------------
-- Tachi Ageha
-- Great Katana weapon skill
-- Skill Level: 300
-- Lowers target's defense. Chance of lowering target's defense varies with TP.
-- 30% Defense Down
-- Duration of effect is exactly 3 minutes.
-- Aligned with the Shadow Gorget, Soil Gorget.
-- Aligned with the Shadow Belt, Soil Belt.
-- Element: None
-- Skillchain Properties: Compression/Scission
-- Modifiers: CHR:60% STR:40%
-- 100%TP    200%TP    300%TP
-- 2.625     2.625      2.625
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 2.80, 2.80, 2.80 }
    params.chr_wsc = 0.50

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 2.625, 2.625, 2.625 }
        params.str_wsc = 0.4 params.chr_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 and not target:hasStatusEffect(xi.effect.DEFENSE_DOWN) then
        local duration = (tp / 1000 * 60) * applyResistanceAddEffect(player, target, xi.element.WIND, 0)
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 25, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
