-----------------------------------
-- ToAU era Archery weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_archery')

-- Flaming Arrow
m:addOverride('xi.actions.weaponskills.flaming_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 0.5, 0.75, 1.0 }
    params.str_wsc    = 0.16
    params.agi_wsc    = 0.25
    params.hybridWS   = true
    params.ele        = xi.element.FIRE
    params.skill      = xi.skill.ARCHERY
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Piercing Arrow
m:addOverride('xi.actions.weaponskills.piercing_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.16
    params.agi_wsc = 0.25
    -- Defense ignored is 0%, 35%, 50% as per wiki.bluegartr.com
    params.ignoredDefense = { 0.0, 0.35, 0.5 }
    -- https://www.ffxiah.com/forum/topic/52018/luck-of-the-draw-a-corsairs-guide-new/127/#3726841 (split shot is a clone of piercing arrow)
    params.rangedAccuracyBonus = 30

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Dulling Arrow
m:addOverride('xi.actions.weaponskills.dulling_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.16
    params.agi_wsc    = 0.25
    params.critVaries = { 0.1, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Fire based INT down https://w.atwiki.jp/studiogobli/pages/74.html
    local effectId = xi.effect.INT_DOWN
    local actionElement = xi.element.FIRE
    local power = 5 -- TODO - Investigate INT Down potency - this guess is based on the lowest tier of Burn
    local duration = math.floor((6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Sidewinder
m:addOverride('xi.actions.weaponskills.sidewinder.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 5.0, 5.0, 5.0 }
    params.str_wsc = 0.16
    params.agi_wsc = 0.25
    params.rangedAccuracyBonus = math.floor(-25 * xi.weaponskills.fTP(tp, { 2, 1, 0 }))

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Blast Arrow
m:addOverride('xi.actions.weaponskills.blast_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 2.0, 2.0, 2.0 }
    params.str_wsc = 0.16
    params.agi_wsc = 0.25
    params.rangedAccuracyBonus = math.floor(25 * xi.weaponskills.fTP(tp, { 0, 1, 2 }))

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Arching Arrow
m:addOverride('xi.actions.weaponskills.arching_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 3.5, 3.5, 3.5 }
    params.str_wsc    = 0.16
    params.agi_wsc    = 0.25
    params.critVaries = { 0.1, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Empyreal Arrow
m:addOverride('xi.actions.weaponskills.empyreal_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 1.5, 2.0, 2.5 }
    params.atkVaries = { 2.0, 2.0, 2.0 }
    params.str_wsc   = 0.16
    params.agi_wsc   = 0.25
    -- https://www.ffxiah.com/forum/topic/52018/luck-of-the-draw-a-corsairs-guide-new/127/#3726841 (Empyreal Arrow is a bow copy of Detonator)
    params.rangedAccuracyBonus = 100

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Namas Arrow
m:addOverride('xi.actions.weaponskills.namas_arrow.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 2.75, 2.75, 2.75 }
    params.str_wsc    = 0.4
    params.agi_wsc    = 0.4
    params.overrideCE = 160
    params.overrideVE = 480
    params.rangedAccuracyBonus = 100

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.RANGED, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, wsID, params, tp, action, primary)

    return tpHits, extraHits, criticalHit, damage
end)

return m
