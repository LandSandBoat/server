-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_marksmanship')

-----------------------------------
-- Hot Shot
-----------------------------------
m:addOverride('xi.actions.weaponskills.hot_shot.onUseWeaponSkill', function(player, target, wsID, tp, primary, action)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.agi_wsc    = 0.3
    params.hybridWS   = true
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.MARKSMANSHIP
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Split Shot
-----------------------------------
m:addOverride('xi.actions.weaponskills.split_shot.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 1.00, 1.00, 1.00 }
    params.agi_wsc             = 0.3
    params.ignoredDefense      = { 0.00, 0.35, 0.50 }
    params.rangedAccuracyBonus = 30

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Sniper Shot
-----------------------------------
m:addOverride('xi.actions.weaponskills.sniper_shot.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.agi_wsc    = 0.3
    params.critVaries = { 0.10, 0.30, 0.50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Handle status effect
    local effectId      = xi.effect.INT_DOWN
    local actionElement = xi.element.FIRE
    local power         = 10
    local skillType     = xi.skill.MARKSMANSHIP
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(140 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Slug Shot
-----------------------------------
m:addOverride('xi.actions.weaponskills.slug_shot.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 5.00, 5.00, 5.00 }
    params.agi_wsc             = 0.3
    params.rangedAccuracyBonus = math.floor(-25 * xi.weaponskills.fTP(tp, { 2, 1, 0 }))

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blast Shot
-----------------------------------
m:addOverride('xi.actions.weaponskills.blast_shot.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 2.00, 2.00, 2.00 }
    params.agi_wsc             = 0.3
    params.rangedAccuracyBonus = math.floor(25 * xi.weaponskills.fTP(tp, { 0, 1, 2 }))

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Heavy Shot
-----------------------------------
m:addOverride('xi.actions.weaponskills.heavy_shot.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 3.50, 3.50, 3.50 }
    params.agi_wsc    = 0.3
    params.critVaries = { 0.10, 0.30, 0.50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Detonator
-----------------------------------
m:addOverride('xi.actions.weaponskills.detonator.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 1.5, 2.0, 2.5 }
    params.atkVaries           = { 2.0, 2.0, 2.0 }
    params.agi_wsc             = 0.3
    params.rangedAccuracyBonus = 100

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Coronach
-----------------------------------
m:addOverride('xi.actions.weaponskills.coronach.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 3.0, 3.0, 3.0 }
    params.dex_wsc             = 0.4
    params.agi_wsc             = 0.4
    params.overrideCE          = 80
    params.overrideVE          = 240
    params.rangedAccuracyBonus = 100

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Trueflight
-----------------------------------
m:addOverride('xi.actions.weaponskills.trueflight.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 4.0, 4.25, 4.75 }
    params.agi_wsc    = 0.3
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.MARKSMANSHIP
    params.includemab = true
    params.dStat      = xi.mod.AGI

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Leaden Salute
-----------------------------------
m:addOverride('xi.actions.weaponskills.leaden_salute.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 4.0, 4.25, 4.75 }
    params.agi_wsc    = 0.3
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.MARKSMANSHIP
    params.includemab = true
    params.dStat      = xi.mod.AGI

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

return m
