-----------------------------------
-- Rudra's Storm
-- Dagger weapon skill
-- Skill level: N/A
-- Deals triple damage and weighs target down (duration: 60s). Damage varies with TP.
-- Aligned with the Aqua Gorget, Snow Gorget & Shadow Gorget.
-- Aligned with the Aqua Belt, Snow Belt & Shadow Belt.
-- Element: None
-- Modifiers: DEX:80%
-- 100%TP    200%TP    300%TP
-- 6          15        19.5
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.25, 4.25, 5.25 }
    params.dex_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 5.0, 10.19, 13.0 }
        params.dex_wsc = 0.8
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- xi.effect.WEIGHT power value is equal to lead breath as per bg-wiki: http://www.bg-wiki.com/bg/Rudra%27s_Storm
    if damage > 0 then
        if not target:hasStatusEffect(xi.effect.WEIGHT) then
            target:addStatusEffect(xi.effect.WEIGHT, 50, 0, 60)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
