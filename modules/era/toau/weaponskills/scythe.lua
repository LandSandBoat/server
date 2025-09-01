-----------------------------------
-- ToAU era scythe weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_scythe')

-- Slice
m:addOverride('xi.actions.weaponskills.slice.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.5, 1.75, 2.0 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Dark Harvest
m:addOverride('xi.actions.weaponskills.dark_harvest.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.SCYTHE
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Shadow of Death
m:addOverride('xi.actions.weaponskills.shadow_of_death.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.5, 3.0 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.SCYTHE
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Nightmare Scythe
m:addOverride('xi.actions.weaponskills.nightmare_scythe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3
    params.chr_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId = xi.effect.BLINDNESS
    local actionElement = xi.element.DARK
    local power = 25
    -- 60/120/180 seconds at 1000/2000/3000 TP https://www.bg-wiki.com/ffxi/Nightmare_Scythe
    local duration = math.floor((6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Spinning Scythe
m:addOverride('xi.actions.weaponskills.spinning_scythe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.0, 1.0, 1.0 }
    params.str_wsc = 0.3
    params.isAoE   = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end)

-- Vorpal Scythe
m:addOverride('xi.actions.weaponskills.vorpal_scythe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.35
    params.critVaries = { 0.4, 0.6, 0.8 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end)

-- Guillotine
m:addOverride('xi.actions.weaponskills.guillotine.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod  = { 0.875, 0.875, 0.875 }
    params.str_wsc = 0.25
    params.mnd_wsc = 0.25

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId = xi.effect.SILENCE
    local actionElement = xi.element.WIND
    local power = 1
    local duration = math.floor((6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Cross Reaper
m:addOverride('xi.actions.weaponskills.cross_reaper.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 2.0, 2.25, 2.5 }
    params.str_wsc = 0.3
    params.int_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Spiral Hell
m:addOverride('xi.actions.weaponskills.spiral_hell.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1.375, 1.875, 3.625 }
    params.str_wsc = 0.5
    params.int_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Catastrophe
m:addOverride('xi.actions.weaponskills.catastrophe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 2.75, 2.75, 2.75 }
    params.agi_wsc = 0.4
    params.int_wsc = 0.4

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Catastrophe heals the player for a random amount between 30 and 70% of the damage dealt
    if not target:isUndead() then
        damage = damage * math.random(30, 70) / 100
        player:addHP(damage)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-- Insurgency
m:addOverride('xi.actions.weaponskills.insurgency.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 4
    params.ftpMod  = { 0.5, 0.75, 1.0 }
    params.str_wsc = 0.2
    params.int_wsc = 0.2

    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
