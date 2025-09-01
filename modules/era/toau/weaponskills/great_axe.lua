-----------------------------------
-- ToAU era great axe weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_great_axe')

-- Shield Break
m:addOverride('xi.actions.weaponskills.shield_break.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.2
    params.vit_wsc = 0.2
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    -- https://w.atwiki.jp/studiogobli/pages/74.html
    local effectId      = xi.effect.EVASION_DOWN
    local actionElement = xi.element.ICE
    local power         = 40
    local duration      = math.floor((120 + 6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Iron Tempest
m:addOverride('xi.actions.weaponskills.iron_tempest.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 1.0, 1.0, 1.0 }
    params.str_wsc   = 0.3
    params.atkVaries = { 1.0, 1.25, 1.5 } -- https://w.atwiki.jp/studiogobli/pages/93.html

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Sturmwind
m:addOverride('xi.actions.weaponskills.sturmwind.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 2
    params.ftpMod    = { 1.0, 1.0, 1.0 }
    params.str_wsc   = 0.3
    -- Basing Sturmwind's attack bonus on Iron Tempest, as they both received the same buffs in 2014 to the same attack bonus anchor points as well.
    params.atkVaries = { 1.0, 1.25, 1.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Armor Break
m:addOverride('xi.actions.weaponskills.armor_break.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.2
    params.vit_wsc = 0.2

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Handle status effect
    -- https://w.atwiki.jp/studiogobli/pages/74.html
    local effectId      = xi.effect.DEFENSE_DOWN
    local actionElement = xi.element.WIND
    local power         = 25
    local duration      = math.floor((120 + 6 * tp / 100) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Keen Edge
m:addOverride('xi.actions.weaponskills.keen_edge.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.35
    -- TODO: Needs testing to verify. We know Backhand Blow is 40% @ 1k TP and is in this level range
    params.critVaries = { 0.4, 0.6, 0.8 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Weapon Break
m:addOverride('xi.actions.weaponskills.weapon_break.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.32
    params.vit_wsc = 0.32
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Handle status effect
    -- https://w.atwiki.jp/studiogobli/pages/74.html
    local effectId      = xi.effect.ATTACK_DOWN
    local actionElement = xi.element.WATER
    local power         = 25
    local duration      = math.floor(120 + 6 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Raging Rush
m:addOverride('xi.actions.weaponskills.raging_rush.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 3
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.35
    params.critVaries = { 0.15, 0.3, 0.5 } -- https://robonosto.blogspot.com/2010/06/weapon-skill-critical-hit-rate-bonus.html

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Full Break
m:addOverride('xi.actions.weaponskills.full_break.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.5
    params.vit_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effects.
    -- https://w.atwiki.jp/studiogobli/pages/74.html
    local effects =
    {
        [1] = { xi.effect.ATTACK_DOWN,   xi.element.WATER, 12.5 },
        [2] = { xi.effect.DEFENSE_DOWN,  xi.element.WIND,  12.5 },
        [3] = { xi.effect.ACCURACY_DOWN, xi.element.EARTH, 20   },
        [4] = { xi.effect.EVASION_DOWN,  xi.element.ICE,   20   },
    }
    for index = 1, #effects do
        local effectId      = effects[index][1]
        local actionElement = effects[index][2]
        local power         = effects[index][3]
        local duration      = math.floor(120 + 6 * tp / 100 * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-- Steel Cyclone
m:addOverride('xi.actions.weaponskills.steel_cyclone.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 1.5, 1.75, 3.0 }
    params.str_wsc   = 0.5
    params.vit_wsc   = 0.5
    params.atkVaries = { 1.5, 1.5, 1.5 } -- https://w.atwiki.jp/studiogobli/pages/93.html

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Metatron Torment
m:addOverride('xi.actions.weaponskills.metatron_torment.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 2.75, 2.75, 2.75 }
    params.str_wsc = 0.6
    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    -- https://www.bluegartr.com/threads/83513-Metatron-Torment-Aftermath
    local effectId      = xi.effect.DEFENSE_DOWN
    local actionElement = xi.element.WIND
    -- TODO: This should be 48/256 but the addMod function takes an int so it would floor if we set power to 18.75
    local power         = 19
    local duration      = math.floor(120 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- King's Justice
m:addOverride('xi.actions.weaponskills.kings_justice.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 3
    params.ftpMod = { 1.0, 1.25, 1.5 }
    params.str_wsc = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

return m
