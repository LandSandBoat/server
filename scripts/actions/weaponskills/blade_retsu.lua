-----------------------------------
-- Blade Retsu
-- Katana weapon skill
-- Skill Level: 30
-- Delivers a two-hit attack. Paralyzes enemy. Duration of paralysis varies with TP.
-- Proc rate of Paralyze seems to be based on your level in comparison to the targets level. The higher level you are compared to your target, it will be Paralyzed more often.
-- Will stack with Sneak Attack.
-- Aligned with the Soil Gorget.
-- Aligned with the Soil Belt.
-- Element: None
-- Modifiers: STR:20%  DEX:20%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.2
    params.dex_wsc = 0.2

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.PARALYSIS
    local actionElement = xi.element.ICE
    local power         = utils.clamp(30 + 3 * (player:getMainLvl() - target:getMainLvl()), 5, 35)
    local duration      = math.floor(3 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
