-----------------------------------
-- Stardiver
-- Polearm weapon skill
-- Skill Level: MERIT
-- Delivers a fourfold attack. Damage varies with TP.
-- Will stack with Sneak Attack.     reduces params.crit hit evasion by 5%
-- Element: None
-- Modifiers: STR:73~85%
-- 100%TP    200%TP    300%TP
-- 0.75         1.25       1.75
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params       = {}
    params.numHits     = 4
    params.ftpMod      = { 0.75, 1.25, 1.75 }
    params.str_wsc     = player:getMerit(xi.merit.STARDIVER) * 0.17
    params.multiHitfTP = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.str_wsc = 0.7 + player:getMerit(xi.merit.STARDIVER) * 0.03
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.CRIT_HIT_EVASION_DOWN
    local actionElement = xi.element.EARTH
    local power         = 5
    local duration      = math.floor(60 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
