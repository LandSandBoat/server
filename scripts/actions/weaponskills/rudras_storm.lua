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
    params.ftp100 = 3.25 params.ftp200 = 4.25 params.ftp300 = 5.25
    params.str_wsc = 0.0 params.dex_wsc = 0.6 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 5 params.ftp200 = 10.19 params.ftp300 = 13
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
