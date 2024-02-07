-----------------------------------
-- Tachi: Fudo
-- Great Katana weapon skill
-- Skill Level: N/A
-- Deals double damage. Damage varies with TP. Masamune: Aftermath.
-- Available only when equipped with Masamune (85), Masamune (90), Masamune (95), Hiradennotachi +1 or Hiradennotachi +2.
-- Aligned with Light Gorget, Snow Gorget & Aqua Gorget.
-- Aligned with Light Belt, Snow Belt & Aqua Belt.
-- Element: None
-- Modifiers: STR:80%
-- 100%TP    200%TP    300%TP
-- 3.75      5.75        8
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.75, 4.75, 5.75 }
    params.str_wsc = 0.60
    params.atkVaries = { 2.0, 2.0, 2.0 }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 3.75, 5.75, 8.0 }
        params.str_wsc = 0.8
        params.atkVaries = { 1.0, 1.0, 1.0 }
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.EMPYREAN)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
