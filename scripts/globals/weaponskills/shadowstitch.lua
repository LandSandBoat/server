-----------------------------------
-- Shadowstitch
-- Dagger weapon skill
-- Skill level: 70
-- Binds target. Chance of binding varies with TP.
-- Does stack with Sneak Attack.
-- Aligned with the Aqua Gorget.
-- Aligned with the Aqua Belt.
-- Element: None
-- Modifiers: CHR:100%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.3
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 1 params.acc200 = 1 params.acc300 = 1
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1

    local effectParams = {}
    effectParams.element = xi.magic.ele.ICE
    effectParams.effect = xi.effect.BIND
    effectParams.skillType = xi.skill.DAGGER
    effectParams.duration = 5 + (tp / 1000 * 5)
    effectParams.power = 1
    effectParams.tick = 0
    effectParams.maccBonus = 0
    effectParams.chance = tp - 1000

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if damage > 0 then
        xi.magic.applyAbilityResistance(player, target, effectParams)
    end

    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
