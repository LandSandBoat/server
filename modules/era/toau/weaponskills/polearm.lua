-----------------------------------
-- ToAU era polearm weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_polearm')

-- Double Thrust
m:addOverride('xi.actions.weaponskills.double_thrust.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Thunder Thrust
m:addOverride('xi.actions.weaponskills.thunder_thrust.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.5, 2.0, 2.5 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.THUNDER
    params.skill      = xi.skill.POLEARM
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Raiden Thrust
m:addOverride('xi.actions.weaponskills.raiden_thrust.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 3.0 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.ele        = xi.element.THUNDER
    params.skill      = xi.skill.POLEARM
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Leg Sweep
m:addOverride('xi.actions.weaponskills.leg_sweep.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    if math.random(1, 100) <= tp / 30 * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) then
        local effectId      = xi.effect.STUN
        local actionElement = xi.element.THUNDER
        local power         = 1
        local duration      = math.floor(4 * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-- Penta Thrust
m:addOverride('xi.actions.weaponskills.penta_thrust.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 5
    params.ftpMod    = { 1.0, 1.0, 1.0 }
    params.str_wsc   = 0.2
    params.dex_wsc   = 0.2
    params.accVaries = { 0.8, 0.9, 1.0 } -- TODO: Change to flat values, also supposedly positive
    params.atkVaries = { 0.875, 0.875, 0.875 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Vorpal Thrust
m:addOverride('xi.actions.weaponskills.vorpal_thrust.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.2
    params.agi_wsc    = 0.2
    params.critVaries = { 0.3, 0.6, 0.9 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Skewer
m:addOverride('xi.actions.weaponskills.skewer.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 3
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.35
    params.critVaries = { 0.1, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Wheeling Thrust
m:addOverride('xi.actions.weaponskills.wheeling_thrust.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits        = 1
    params.ftpMod         = { 1.75, 1.75, 1.75 }
    params.str_wsc        = 0.5
    params.ignoredDefense = { 0.5, 0.625, 0.75 } -- https://wiki.ffo.jp/html/898.html

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Impulse Drive
m:addOverride('xi.actions.weaponskills.impulse_drive.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.0, 1.5, 2.5 }
    params.str_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Geirskogul
m:addOverride('xi.actions.weaponskills.geirskogul.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 3.0, 3.0, 3.0 }
    params.agi_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Drakesbane
m:addOverride('xi.actions.weaponskills.drakesbane.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 4
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.5
    params.critVaries = { 0.1, 0.3, 0.5 }
    params.atkVaries  = { 0.8125, 0.8125, 0.8125 }

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
