-----------------------------------
-- Shield Break
-- Great Axe weapon skill
-- Skill level: 5
-- Lowers enemy's Evasion. Duration of effect varies with TP.
-- Lowers Evasion by as much as 40 if unresisted.
-- Strong against: Bees, Beetles, Birds, Crabs, Crawlers, Flies, Lizards, Mandragora, Opo-opo, Pugils, Sabotenders, Scorpions, Sea Monks, Spiders, Tonberry, Yagudo.
-- Immune: Bombs, Gigas, Ghosts, Sheep, Skeletons, Tigers.
-- Will stack with Sneak Attack.
-- Aligned with the Thunder Gorget.
-- Aligned with the Thunder Belt.
-- Element: Ice
-- Modifiers: STR:60%  VIT:60%
-- 100%TP    200%TP    300%TP
-- 1.00      1.00      1.00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------

function onUseWeaponSkill(player, target, wsID, tp, primary, action, taChar)

    local params = {}
    params.numHits = 1
    params.ftp100 = 1 params.ftp200 = 1 params.ftp300 = 1
    params.str_wsc = 0.2 params.dex_wsc = 0.0 params.vit_wsc = 0.2 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.crit100 = 0.0 params.crit200 = 0.0 params.crit300 = 0.0
    params.canCrit = false
    params.acc100 = 0.0 params.acc200= 0.0 params.acc300= 0.0
    params.atk100 = 1; params.atk200 = 1; params.atk300 = 1

    if (USE_ADOULIN_WEAPON_SKILL_CHANGES == true) then
        params.str_wsc = 0.6 params.vit_wsc = 0.6
    end

    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    if (damage > 0 and target:hasStatusEffect(tpz.effect.EVASION_DOWN) == false) then
        local duration = (120 + (tp/1000 * 60)) * applyResistanceAddEffect(player, target, tpz.magic.ele.ICE, 0)
        target:addStatusEffect(tpz.effect.EVASION_DOWN, 40, 0, duration)
    end
    return tpHits, extraHits, criticalHit, damage

end
