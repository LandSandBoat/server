-----------------------------------
-- ToAU era dagger weaponskill module
-- Sets fTP, WSC and additional effects to their ToAU values
-- Target date: 2007-11-19 (one day prior to WotG release)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('toau_weaponskills_dagger')

-- Wasp Sting
m:addOverride('xi.actions.weaponskills.wasp_sting.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    local effectId      = xi.effect.POISON
    local actionElement = xi.element.WATER
    local power         = 1
    local duration      = math.floor((xi.weaponskills.fTP(tp, { 90, 105, 135 })) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Gust Slash
m:addOverride('xi.actions.weaponskills.gust_slash.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.0, 2.5 }
    params.dex_wsc    = 0.2
    params.int_wsc    = 0.2
    params.ele        = xi.element.WIND
    params.skill      = xi.skill.DAGGER
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Shadowstitch
m:addOverride('xi.actions.weaponskills.shadowstitch.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 1, 1, 1 }
    params.chr_wsc = 0.3

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)

    -- Handle status effect
    if math.random(1, 100) <= tp / 30 * applyResistanceAddEffect(player, target, xi.element.ICE, 0) then
        local effectId      = xi.effect.BIND
        local actionElement = xi.element.ICE
        local power         = 1
        local duration      = math.floor((10 + tp / 200) * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

-- Viper Bite
m:addOverride('xi.actions.weaponskills.viper_bite.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 1, 1, 1 }
    params.atkVaries = { 2, 2, 2 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Handle status effect
    local effectId      = xi.effect.POISON
    local actionElement = xi.element.WATER
    local power         = 3
    local duration      = math.floor(xi.weaponskills.fTP(tp, { 90, 120, 180 }) * applyResistanceAddEffect(player, target, actionElement, 0))
    xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)

    return tpHits, extraHits, criticalHit, damage
end)

-- Cyclone
m:addOverride('xi.actions.weaponskills.cyclone.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.ftpMod     = { 1.0, 2.375, 2.875 }
    params.dex_wsc    = 0.3
    params.int_wsc    = 0.25
    params.ele        = xi.element.WIND
    params.skill      = xi.skill.DAGGER
    params.includemab = true

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doMagicWeaponskill(player, target, wsID, params, tp, action, primary)
    return tpHits, extraHits, criticalHit, damage
end)

-- Energy Steal
m:addOverride('xi.actions.weaponskills.energy_steal.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local fTPAnchors = { 1.0, 1.5, 2 }
    local startingAnchor = math.floor(tp / 1000)
    local multiplier = 0
    if tp >= 3000 then
        multiplier = fTPAnchors[3]
    else
        local basefTP   = fTPAnchors[startingAnchor]
        local nextfTP   = fTPAnchors[startingAnchor + 1]
        local multPerTP = (nextfTP - basefTP) / 1000 * (tp - 1000 * startingAnchor)
        multiplier = basefTP + multPerTP
    end

    local skill = player:getSkillLevel(xi.skill.DAGGER)
    local wsc   = player:getStat(xi.mod.MND) * 1.0
    local mpRestored = math.floor((math.floor(skill * 0.11) + wsc) * multiplier)
    if target:isUndead() then
        mpRestored = 0
    else
        mpRestored = target:delMP(mpRestored)
        mpRestored = player:addMP(mpRestored)
    end

    action:messageID(target:getID(), xi.msg.basic.SKILL_DRAIN_MP)
    action:param(target:getID(), mpRestored)
    return 1, 0, false, mpRestored
end)

-- Energy Drain
m:addOverride('xi.actions.weaponskills.energy_drain.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local fTPAnchors = { 1.25, 2.5, 4.125 }
    local startingAnchor = math.floor(tp / 1000)
    local multiplier = 0
    if tp >= 3000 then
        multiplier = fTPAnchors[3]
    else
        local basefTP   = fTPAnchors[startingAnchor]
        local nextfTP   = fTPAnchors[startingAnchor + 1]
        local multPerTP = (nextfTP - basefTP) / 1000 * (tp - 1000 * startingAnchor)
        multiplier = basefTP + multPerTP
    end

    local skill = player:getSkillLevel(xi.skill.DAGGER)
    local wsc   = player:getStat(xi.mod.MND) * 1.0
    local mpRestored = math.floor((math.floor(skill * 0.11) + wsc) * multiplier)
    if target:isUndead() then
        mpRestored = 0
    else
        mpRestored = target:delMP(mpRestored)
        mpRestored = player:addMP(mpRestored)
    end

    action:messageID(target:getID(), xi.msg.basic.SKILL_DRAIN_MP)
    action:param(target:getID(), mpRestored)
    return 1, 0, false, mpRestored
end)

-- Dancing Edge
m:addOverride('xi.actions.weaponskills.dancing_edge.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 5
    params.ftpMod    = { 1.1875, 1.1875, 1.1875 }
    params.dex_wsc   = 0.3
    params.chr_wsc   = 0.4
    -- TODO: Flat accuracy bonus
    params.accVaries = { 1, 1, 1 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Shark Bite
m:addOverride('xi.actions.weaponskills.shark_bite.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftpMod  = { 2.0, 2.5, 3.0 }
    params.dex_wsc = 0.5

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Evisceration
m:addOverride('xi.actions.weaponskills.evisceration.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits    = 5
    params.ftpMod     = { 1.0, 1.0, 1.0 }
    params.dex_wsc    = 0.3
    params.critVaries = { 0.1, 0.3, 0.5 }

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Mercy Stroke
m:addOverride('xi.actions.weaponskills.mercy_stroke.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 1
    params.ftpMod  = { 3.0, 3.0, 3.0 }
    params.str_wsc = 0.6

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.RELIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Mandalic Stab
m:addOverride('xi.actions.weaponskills.mandalic_stab.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits   = 1
    params.ftpMod    = { 2.0, 2.125, 2.5 }
    params.dex_wsc   = 0.3
    params.atkVaries = { 1.75, 1.75, 1.75 } -- https://w.atwiki.jp/studiogobli/pages/93.html

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end)

-- Mordant Rime
m:addOverride('xi.actions.weaponskills.mordant_rime.onUseWeaponSkill', function(player, target, wsID, tp, primary, action, taChar)
    local params   = {}
    params.numHits = 2
    params.ftpMod  = { 3, 3, 3 }
    params.dex_wsc = 0.3
    params.chr_wsc = 0.5

    -- Apply aftermath
    xi.aftermath.addStatusEffect(player, tp, xi.slot.MAIN, xi.aftermath.type.MYTHIC)

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    -- Handle status effect
    if math.random(1, 100) <= tp / 30 * applyResistanceAddEffect(player, target, xi.element.THUNDER, 0) then
        local effectId      = xi.effect.WEIGHT
        local actionElement = xi.element.WIND
        local power         = 25
        local duration      = math.floor(60 * applyResistanceAddEffect(player, target, actionElement, 0))
        xi.weaponskills.handleWeaponskillEffect(player, target, effectId, actionElement, damage, power, duration)
    end

    return tpHits, extraHits, criticalHit, damage
end)

return m
