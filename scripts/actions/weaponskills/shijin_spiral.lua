-----------------------------------
-- Shijin Spiral
-- Hand-to-Hand weapon skill
-- Skill Level: N/A
-- Delivers a fivefold attack that Plagues the target. Chance of inflicting Plague varies with TP.
-- In order to obtain Shijin Spiral, the quest Martial Mastery must be completed.
-- Aligned with the Flame Gorget, Light Gorget & Aqua Gorget.
-- Aligned with the Flame Belt, Light Belt & Aqua Belt.
-- Element: None
-- Modifiers: DEX: 73~85%
-- 100%TP    200%TP    300%TP
-- 1.0625    1.0625    1.0625
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 5
    params.ftpMod = { 1.0625, 1.0625, 1.0625 }
    params.dex_wsc = player:getMerit(xi.merit.SHIJIN_SPIRAL) * 0.17
    params.atkVaries = { 1.05, 1.05, 1.05 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.multiHitfTP = true -- http://wiki.ffo.jp/html/25607.html
        params.ftpMod = { 1.5, 1.5, 1.5 }
        params.dex_wsc = 0.7 + (player:getMerit(xi.merit.SHIJIN_SPIRAL) * 0.03)
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 then
        local duration = (tp / 1000) + 4
        if not target:hasStatusEffect(xi.effect.PLAGUE) then
            target:addStatusEffect(xi.effect.PLAGUE, 5, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
