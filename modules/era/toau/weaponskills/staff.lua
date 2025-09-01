-----------------------------------
-- ToAU era staff weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_staff')

-- Heavy Swing
m:addOverride('xi.actions.weaponskills.heavy_swing.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.25, 2.25 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Rock Crusher
m:addOverride('xi.actions.weaponskills.rock_crusher.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.EARTH
    params.skill      = xi.skill.STAFF
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Earth Crusher
m:addOverride('xi.actions.weaponskills.earth_crusher.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.3125, 3.625 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.ele        = xi.element.EARTH
    params.skill      = xi.skill.STAFF
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Starburst
m:addOverride('xi.actions.weaponskills.starburst.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.skill      = xi.skill.STAFF
    params.includemab = true
    params.ele        = xi.element.LIGHT

    if math.random(1, 100) <= 50 then
        params.ele = xi.element.DARK
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Sunburst
m:addOverride('xi.actions.weaponskills.sunburst.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.5, 4.0 }
    params.skill      = xi.skill.STAFF
    params.includemab = true
    params.ele        = xi.element.LIGHT

    if math.random(1, 100) <= 50 then
        params.ele = xi.element.DARK
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Shell Crusher
m:addOverride('xi.actions.weaponskills.shell_crusher.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.35

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.DEFENSE_DOWN
    local actionElement = xi.element.WIND
    local power         = 25
    local duration      = math.floor((120 + 6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Full Swing
m:addOverride('xi.actions.weaponskills.full_swing.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 3.0, 5.0 }
    params.str_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Spirit Taker
m:addOverride('xi.actions.weaponskills.spirit_taker.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.5, 2.0 }
    params.int_wsc = 0.5
    params.mnd_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    player:addMP(damage)

    return tpHits, extraHits, criticalHit, damage
end)

-- Retribution
m:addOverride('xi.actions.weaponskills.retribution.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params     = {}
    params.numHits   = 1
    params.ftpMod    = { 2.0, 2.5, 3.0 }
    params.atkVaries = { 1.5, 1.5, 1.5 }
    params.str_wsc   = 0.3
    params.mnd_wsc   = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Gate of Tartarus
m:addOverride('xi.actions.weaponskills.gate_of_tartarus.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 3, 3, 3 }
    params.chr_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.ATTACK_DOWN
    local actionElement = xi.element.WATER
    local power         = 20
    local duration      = math.floor(120 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Vidohunir
m:addOverride('xi.actions.weaponskills.vidohunir.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.75, 1.75, 1.75 }
    params.int_wsc    = 0.3
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.STAFF
    params.includemab = true

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Handle status effect
    local effectId      = xi.effect.MAGIC_DEF_DOWN
    local actionElement = xi.element.THUNDER
    local power         = 10
    local duration      = math.floor(6 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Garland of Bliss
m:addOverride('xi.actions.weaponskills.garland_of_bliss.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 2.25, 2.25, 2.25 }
    params.str_wsc    = 0.3
    params.mnd_wsc    = 0.3
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.STAFF
    params.includemab = true

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)

    -- Handle status effect
    local effectId      = xi.effect.DEFENSE_DOWN
    local actionElement = xi.element.WIND
    local power         = 13 -- TODO: Should be 12.5 but effects are using integer division so it would floor
    local duration      = math.floor((6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

return m
