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
require("scripts/globals/aftermath")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftp100 = 1.75 params.ftp200 = 1.75 params.ftp300 = 1.75
    params.str_wsc = 0.0 params.dex_wsc = 0.60 params.vit_wsc = 0.0
    params.agi_wsc = 0.00 params.int_wsc = 0.0 params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.crit100 = 0.15 params.crit200 = 0.2 params.crit300 = 0.25
    params.canCrit = true
    params.acc100 = 0.0 params.acc200 = 0.0 params.acc300 = 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1
    params.multiHitfTP = true

    if USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 0.8
    end

    local damage, criticalHit, tpHits, extraHits, shadowsAbsorbed = doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    if shadowsAbsorbed + tpHits + extraHits == 3 then
        action:speceffect(target:getID(), bit.bor(action:speceffect(target:getID()), 8))
    elseif shadowsAbsorbed + tpHits + extraHits == 2 then
        action:speceffect(target:getID(), bit.bor(action:speceffect(target:getID()), 4))
    end

    -- Apply aftermath
    if damage > 0 then
        tpz.aftermath.addStatusEffect(player, tp, tpz.slot.RANGED, tpz.aftermath.type.EMPYREAN)
    end

    return tpHits, extraHits, criticalHit, damage
end
