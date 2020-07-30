-----------------------------------
-- Bora Axe
-- Axe weapon skill
-- Skill level: 290
-- Delivers a single-hit ranged attack at a maximum distance of 15.7'. Chance of binding varies with TP
-- Bind doesn't always break from hitting mob.
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits
-- Not natively available to RNG
-- Aligned with the ?? Gorget.
-- Element: Ice
-- Modifiers: DEX 60%  -- http://wiki.bluegartr.com/bg/Bora_Axe
-- 100%TP    200%TP    300%TP
-- 1.0        1.0      1.0
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1.0 params.ftp200 = 1.0 params.ftp300 = 1.0
    params.str_wsc = 0.0 params.dex_wsc = 0.6 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 3.5; params.atk200 = 3.5; params.atk300 = 3.5

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.ftp100 = 4.5 params.ftp200 = 4.5 params.ftp300 = 4.5
        params.dex_wsc = 1.0
        params.atk100 = 1.0; params.atk200 = 1.0; params.atk300 = 1.0
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    local chance = (tp-1000) * applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0) > math.random() * 150
    if (damage > 0 and target:hasStatusEffect(tpz.effect.BIND) == false and change) then
        local duration = 20 * applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0)
        target:addStatusEffect(tpz.effect.BIND, 1, 0, duration)
    end
    return tpHits, extraHits, criticalHit, damage

end
