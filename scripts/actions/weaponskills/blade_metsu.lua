-----------------------------------
-- Blade Metsu
-- Katana weapon skill
-- Skill Level: N/A
-- Additional effect: Paralysis
-- Hidden effect: temporarily enhances Subtle Blow xi.effect.
-- One hit weapon skill, despite non single-hit animation.
-- This weapon skill is only available with the stage 5 relic Katana Kikoku or within Dynamis with the stage 4 Yoshimitsu.
-- Weaponskill is also available with the Sekirei Katana obtained from Abyssea NM Sedna.
-- Aligned with the Shadow Gorget, Breeze Gorget & Thunder Gorget.
-- Aligned with the Shadow Belt, Breeze Belt & Thunder Belt.
-- Element: None
-- Modifiers: DEX:60%
-- 100%TP    200%TP    300%TP
-- 3.00      3.00      3.00
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.0, 3.0, 3.0 }
    params.dex_wsc = 0.6

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 5.0, 5.0, 5.0 }
        params.dex_wsc = 0.8
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    if damage > 0 then
        if not target:hasStatusEffect(xi.effect.PARALYSIS) then
            local duration = 60 * applyResistanceAddEffect(player, target, xi.element.ICE, 0)
            target:addStatusEffect(xi.effect.PARALYSIS, 10, 0, duration)
        end
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
