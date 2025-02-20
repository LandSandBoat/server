-----------------------------------
-- Guillotine
-- Scythe weapon skill
-- Skill level: 200
-- Delivers a four-hit attack. Duration varies with TP.
-- Modifiers: STR:25%  MND:25%
-- 100%TP     200%TP     300%TP
-- 0.875    0.875    0.875
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 4
    params.ftpMod  = { 0.875, 0.875, 0.875 }
    params.str_wsc = 0.25
    params.mnd_wsc = 0.25

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.3
        params.mnd_wsc = 0.5
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.SILENCE
    local actionElement = xi.element.WIND
    local power         = 1
    local duration      = math.floor((30 + 3 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
