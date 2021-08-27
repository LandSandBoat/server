-----------------------------------
-- Infernal Scythe
-- Scythe weapon skill
-- Skill Level: 300
-- Deals darkness elemental damage and lowers target's attack. Duration of effect varies with TP.
-- Attack Down effect is -25% attack.
-- Aligned with the Shadow Gorget & Aqua Gorget.
-- Aligned with the Shadow Belt & Aqua Belt.
-- Element: None
-- Modifiers: STR: 30% INT: 30%
-- 100%TP    200%TP    300%TP
-- 3.50        3.50      3.50
-----------------------------------
require("scripts/globals/status")
require("scripts/settings/main")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskill_object = {}

weaponskill_object.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.ftp100 = 3.5 params.ftp200 = 3.5 params.ftp300 = 3.5
    params.str_wsc = 0.3 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.ele = xi.magic.ele.DARK
    params.skill = xi.skill.SCYTHE
    params.includemab = true

    if (xi.settings.USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.int_wsc = 0.7
    end

    local damage, criticalHit, tpHits, extraHits = doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    if (damage > 0 and target:hasStatusEffect(xi.effect.ATTACK_DOWN) == false) then
        local duration = (tp/1000 * 180) * applyResistanceAddEffect(player, target, xi.magic.ele.WATER, 0)
        target:addStatusEffect(xi.effect.ATTACK_DOWN, 25, 0, duration)
    end
    return tpHits, extraHits, criticalHit, damage

end

return weaponskill_object
