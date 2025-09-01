-----------------------------------
-- ToAU era club weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_club')

-- Shining Strike
m:addOverride('xi.actions.weaponskills.shining_strike.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 1.75, 2.5 }
    params.str_wsc    = 0.2
    params.mnd_wsc    = 0.2
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.CLUB
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Seraph Strike
m:addOverride('xi.actions.weaponskills.seraph_strike.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 3.0 }
    params.str_wsc    = 0.3
    params.mnd_wsc    = 0.3
    params.ele        = xi.element.LIGHT
    params.skill      = xi.skill.CLUB
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Brainshaker
m:addOverride('xi.actions.weaponskills.brainshaker.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.STUN
    local actionElement = xi.element.THUNDER
    local power         = 1
    local duration      = math.floor(tp / 500 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Starlight
m:addOverride('xi.actions.weaponskills.starlight.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11)
    local damage = (lvl - 10) / 9
    local damagemod = damage * (tp / 1000)
    damagemod = damagemod * xi.settings.main.WEAPON_SKILL_POWER
    return 1, 0, false, damagemod
end)

-- Moonlight
m:addOverride('xi.actions.weaponskills.moonlight.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local lvl = player:getSkillLevel(11)
    local damage = (lvl / 9) - 1
    local damagemod = damage * ((50 + (tp * 0.05)) / 100)
    damagemod = damagemod * xi.settings.main.WEAPON_SKILL_POWER
    return 1, 0, false, damagemod
end)

-- Skullbreaker
m:addOverride('xi.actions.weaponskills.skullbreaker.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.str_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    -- https://w.atwiki.jp/studiogobli/pages/74.html
    local effectId      = xi.effect.INT_DOWN
    local actionElement = xi.element.FIRE
    local power         = 10
    local duration      = math.floor(140 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    return tpHits, extraHits, criticalHit, damage
end)

-- True Strike
m:addOverride('xi.actions.weaponskills.true_strike.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 1
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.5
    params.critVaries = { 1.0, 1.0, 1.0 }
    params.accVaries  = { 0.5, 0.7, 1.0 }
    params.atkVaries  = { 2.0, 2.0, 2.0 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Judgment
m:addOverride('xi.actions.weaponskills.judgment.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 2.0, 2.5, 4.0 }
    params.str_wsc = 0.32
    params.mnd_wsc = 0.32

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Hexa Strike
m:addOverride('xi.actions.weaponskills.hexa_strike.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 6
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.str_wsc    = 0.2
    params.mnd_wsc    = 0.2
    params.critVaries = { 0.1, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Black Halo
m:addOverride('xi.actions.weaponskills.black_halo.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 1.5, 2.5, 3 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Randgrith
m:addOverride('xi.actions.weaponskills.randgrith.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 2.75, 2.75, 2.75 }
    params.str_wsc = 0.4
    params.mnd_wsc = 0.4

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    -- Handle status effect
    local effectId      = xi.effect.EVASION_DOWN
    local actionElement = xi.element.ICE
    local power         = 32
    local duration      = math.floor(120 * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Mystic Boon
m:addOverride('xi.actions.weaponskills.mystic_boon.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod = { 1.0, 1.5, 2.0 }
    params.str_wsc = 0.3
    params.mnd_wsc = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Heal for damage dealt
    player:addMP(damage)

    return tpHits, extraHits, criticalHit, damage
end)

return m
