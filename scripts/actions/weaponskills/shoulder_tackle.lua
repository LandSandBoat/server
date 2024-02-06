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
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.0, 1.0 }
    params.vit_wsc = 0.3
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/2417.html
        params.vit_wsc = 1.0
    end

    if damage > 0 and not target:hasStatusEffect(xi.effect.STUN) then
        local duration = (tp / 500) * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0)
        target:addStatusEffect(xi.effect.STUN, 1, 0, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
