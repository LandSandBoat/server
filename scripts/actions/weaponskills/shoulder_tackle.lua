-----------------------------------
-- Shoulder Tackle
-- Hand-to-Hand weapon skill
-- Skill Level: 40
-- Stuns target. Chance of stunning varies with TP.
-- Will stack with Sneak Attack.
-- Aligned with the Aqua Gorget & Thunder Gorget.
-- Aligned with the Aqua Belt & Thunder Belt.
-- Element: None
-- Modifiers: VIT:30%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
---@type TWeaponSkill
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.vit_wsc = 0.3
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/2417.html
        params.vit_wsc     = 1
    end

    -- Handle status effect
    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local power         = 1
    local duration      = math.floor(tp / 500 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
