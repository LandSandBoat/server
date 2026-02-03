-----------------------------------
-- Date : 2007-11-19 (One day prior to WoTG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_scythe')

-----------------------------------
-- Slice
-----------------------------------
m:addOverride('xi.actions.weaponskills.slice.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.50, 1.75, 2.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Dark Harvest
-----------------------------------
m:addOverride('xi.actions.weaponskills.dark_harvest.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.00, 2.00, 2.50 }
    params.str_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.SCYTHE
    params.includemab = true
    params.dStat      = xi.mod.INT

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Shadow of Death
-----------------------------------
m:addOverride('xi.actions.weaponskills.shadow_of_death.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.ftpMod     = { 1.00, 2.50, 3.00 }
    params.str_wsc    = 0.3
    params.int_wsc    = 0.3
    params.ele        = xi.element.DARK
    params.skill      = xi.skill.SCYTHE
    params.includemab = true
    params.dStat      = xi.mod.INT

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Nightmare Scythe
-----------------------------------
m:addOverride('xi.actions.weaponskills.nightmare_scythe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params    = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.3
    params.chr_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.BLINDNESS
    local actionElement = xi.element.DARK
    local power         = 20
    local skillType     = xi.skill.SCYTHE
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor((6 * tp / 100) * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Spinning Scythe
-----------------------------------
m:addOverride('xi.actions.weaponskills.spinning_scythe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.00, 1.00, 1.00 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Vorpal Scythe
-----------------------------------
m:addOverride('xi.actions.weaponskills.vorpal_scythe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params      = {}
    params.numHits    = 1
    params.ftpMod     = { 1.00, 1.00, 1.00 }
    params.str_wsc    = 0.35
    params.critVaries = { 0.40, 0.60, 0.80 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Guillotine
-----------------------------------
m:addOverride('xi.actions.weaponskills.guillotine.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 4
    params.ftpMod  = { 0.875, 0.875, 0.875 }
    params.str_wsc = 0.25
    params.mnd_wsc = 0.25

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.SILENCE
    local actionElement = xi.element.WIND
    local power         = 1
    local skillType     = xi.skill.SCYTHE
    local resist        = xi.combat.magicHitRate.calculateResistRate(player, target, 0, skillType, 0, actionElement, 0, effectId, 0)
    local duration      = math.floor((30 + 3 * tp / 100) * resist)
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Cross Reaper
-----------------------------------
m:addOverride('xi.actions.weaponskills.cross_reaper.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 2.0, 2.25, 2.5 }
    params.str_wsc = 0.3
    params.int_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Spiral Hell
-----------------------------------
m:addOverride('xi.actions.weaponskills.spiral_hell.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1.375, 1.875, 3.625 }
    params.str_wsc = 0.5
    params.int_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Catastrophe
-----------------------------------
m:addOverride('xi.actions.weaponskills.catastrophe.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    local targetHP = target:getHP()
    params.numHits = 1
    params.ftpMod  = { 2.75, 2.75, 2.75 }
    params.agi_wsc = 0.4
    params.int_wsc = 0.4

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle HP Drain
    if not target:isUndead() then
        local drain = math.floor(damage * math.random(30, 70) / 100)

        drain = utils.clamp(drain, 0, targetHP)

        player:addHP(drain)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-----------------------------------
-- Insurgency
-----------------------------------
m:addOverride('xi.actions.weaponskills.insurgency.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 4
    params.ftpMod  = { 0.50, 0.75, 1.00 }
    params.str_wsc = 0.2
    params.int_wsc = 0.2

    -- Apply Aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
