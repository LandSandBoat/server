-----------------------------------
-- Cloudsplitter
-- Axe weapon skill
-- Skill level: NA
-- Description: Deals lightning elemental damage. Damage varies with TP. Farsha: Aftermath.
-- Available only when equipped with Farsha (85), Farsha (90) or Alard's Axe +1.
-- Elemental gorgets do not affect damage. Rairin Obi increases damage on Lightning day and/or weather.
-- Element: Lightning
-- Modifiers: STR:40% MND:40%
-- 100%TP    200%TP    300%TP
-- 3.75        5.0      6.0
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod = { 3.75, 5.0, 6.0 }
    params.str_wsc = 0.4 params.mnd_wsc = 0.4
    params.ele = xi.element.THUNDER
    params.skill = xi.skill.AXE
    params.includemab = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.75, 6.7, 8.5 }
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
