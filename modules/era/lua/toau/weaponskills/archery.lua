-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_archery')

-----------------------------------
-- Flaming Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.flaming_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 0.50, 0.75, 1.00 }
    params.str_wsc    = 0.16
    params.agi_wsc    = 0.25
    params.hybridWS   = true
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.ARCHERY
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Piercing Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.piercing_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 1.00, 1.00, 1.00 }
    params.str_wsc             = 0.16
    params.agi_wsc             = 0.25
    params.ignoredDefense      = { 0.00, 0.35, 0.50 }
    params.rangedAccuracyBonus = 30

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Dulling Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.dulling_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.str_wsc    = 0.16
    params.agi_wsc    = 0.25
    params.critVaries = { 0.10, 0.30, 0.50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Handle status effect
    local effectId      = xi.effect.INT_DOWN
    local actionElement = xi.element.FIRE
    local power         = 10
    local skillType     = xi.skill.ARCHERY
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor(140 * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Sidewinder
-----------------------------------
m:addOverride('xi.actions.weaponskills.sidewinder.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 5.00, 5.00, 5.00 }
    params.str_wsc             = 0.16
    params.agi_wsc             = 0.25
    params.rangedAccuracyBonus = math.floor(-25 * xi.weaponskills.fTP(tp, { 2, 1, 0 }))

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Blast Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.blast_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 2.00, 2.00, 2.00 }
    params.str_wsc             = 0.16
    params.agi_wsc             = 0.25
    params.rangedAccuracyBonus = math.floor(25 * xi.weaponskills.fTP(tp, { 0, 1, 2 }))

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Arching Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.arching_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 3.50, 3.50, 3.50 }
    params.str_wsc             = 0.16
    params.agi_wsc             = 0.25
    params.critVaries          = { 0.10, 0.30, 0.50 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Empyreal Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.empyreal_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 1.50, 2.00, 2.50 }
    params.atkVaries           = { 2.00, 2.00, 2.00 }
    params.str_wsc             = 0.16
    params.agi_wsc             = 0.25
    params.rangedAccuracyBonus = 100

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Namas Arrow
-----------------------------------
m:addOverride('xi.actions.weaponskills.namas_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params               = {}
    params.numHits             = 1
    params.ftpMod              = { 2.75, 2.75, 2.75 }
    params.str_wsc             = 0.4
    params.agi_wsc             = 0.4
    params.overrideCE          = 160
    params.overrideVE          = 480
    params.rangedAccuracyBonus = 100

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

return m
