-----------------------------------
-- Jishnu's Radiance
-- Archery weapon skill
-- Skill level: 357
-- Empyrean Weapon Skill
-- RNG Main Job Required
-- Aligned with the Thunder & Breeze Gorget.
-- Aligned with the Thunder Belt & Breeze Belt.
-- Element:
-- Modifiers: DEX:60%
-- 100%TP    200%TP    300%TP
-- 1.75      1.75      1.75
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.75, 1.75, 1.75 }
    params.dex_wsc = 0.60
    params.critVaries = { 0.15, 0.2, 0.25 }
    params.multiHitfTP = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.8
    end

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.EMPYREAN)

    local damage, criticalHit, tpHits, extraHits, shadowsAbsorbed = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    if shadowsAbsorbed + tpHits + extraHits == 3 then
        action:speceffect(target:getID(), bit.bor(action:speceffect(target:getID()), 8))
    elseif shadowsAbsorbed + tpHits + extraHits == 2 then
        action:speceffect(target:getID(), bit.bor(action:speceffect(target:getID()), 4))
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
