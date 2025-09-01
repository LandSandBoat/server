-----------------------------------
-- ToAU era great sword weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_great_sword')

-- Hard Slash
m:addOverride('xi.actions.weaponskills.hard_slash.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.5, 1.75, 2.0 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Power Slash
m:addOverride('xi.actions.weaponskills.power_slash.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.2
    params.vit_wsc    = 0.2
    -- TODO: Needs research to verify. We know Backhand Blow is 40% @ 1k TP and is in this level range
    params.critVaries = { 0.4, 0.6, 0.8 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Frostbite
m:addOverride('xi.actions.weaponskills.frostbite.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.ICE
    params.skill      = xi.skill.GREAT_SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Freezebite
m:addOverride('xi.actions.weaponskills.freezebite.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 1.5, 3.0 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.2
    params.ele        = xi.element.ICE
    params.skill      = xi.skill.GREAT_SWORD
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Shockwave
m:addOverride('xi.actions.weaponskills.shockwave.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.SLEEP_I
    local actionElement = xi.element.DARK
    local power         = 1
    local duration      = math.floor((30 + tp * 0.1) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Crescent Moon
m:addOverride('xi.actions.weaponskills.crescent_moon.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.75, 2.5 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Sickle Moon
m:addOverride('xi.actions.weaponskills.sickle_moon.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.5, 2.0, 2.75 }
    params.str_wsc = 0.2
    params.agi_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Spinning Slash
m:addOverride('xi.actions.weaponskills.spinning_slash.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 2.5, 3.0, 3.5 }
    params.str_wsc   = 0.3
    params.int_wsc   = 0.3
    params.atkVaries = { 1.5, 1.5, 1.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Ground Strike
m:addOverride('xi.actions.weaponskills.ground_strike.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 1.5, 1.75, 3.0 }
    params.str_wsc   = 0.5
    params.int_wsc   = 0.5
    params.atkVaries = { 1.75, 1.75, 1.75 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Scourge
m:addOverride('xi.actions.weaponskills.scourge.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 3.0, 3.0, 3.0 }
    params.mnd_wsc = 0.4
    params.chr_wsc = 0.4

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
