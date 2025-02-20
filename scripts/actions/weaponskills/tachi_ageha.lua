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
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 2.8, 2.8, 2.8 }
    params.chr_wsc = 0.50

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod  = { 2.625, 2.625, 2.625 }
        params.str_wsc = 0.4
        params.chr_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.DEFENSE_DOWN
    local actionElement = xi.element.WIND
    local power         = 25
    local duration      = math.floor(6 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
