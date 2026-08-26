-----------------------------------
-- Module: Ranger Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_ranger')

local function useEagleEyeShot(player, target, action, enmityMult)
    if player:getWeaponSkillType(xi.slot.RANGED) == xi.skill.MARKSMANSHIP then
        action:setAnimation(target:getID(), action:getAnimation(target:getID()) + 1)
    end

    local params = {}

    params.numHits = 1

    -- TP params.
    local tp          = 1000 -- to ensure ftp multiplier is applied
    params.ftpMod     = { 5.0, 5.0, 5.0 }
    params.critVaries = { 0.0, 0.0, 0.0 }

    -- Stat params.
    params.str_wsc = 0
    params.dex_wsc = 0
    params.vit_wsc = 0
    params.agi_wsc = 0
    params.int_wsc = 0
    params.mnd_wsc = 0
    params.chr_wsc = 0

    params.enmityMult = enmityMult

    -- Job Point Bonus Damage
    local jpValue = player:getJobPointLevel(xi.jp.EAGLE_EYE_SHOT_EFFECT)
    player:addMod(xi.mod.ALL_WSDMG_ALL_HITS, jpValue * 3)

    local damage, _, tpHits, extraHits = xi.weaponskills.doRangedWeaponskill(player, target, 0, params, tp, action, true)

    -- Set the message id ourselves
    if tpHits + extraHits > 0 then
        action:messageID(target:getID(), xi.msg.basic.JA_DAMAGE)
    else
        action:messageID(target:getID(), xi.msg.basic.JA_MISS_2)
    end

    return damage
end

m:addOverrideByEra('xi.job_utils.ranger.useEagleEyeShot', {
    -- Revert shadow bypass
    -- Source: https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
    [xi.expansion.ROV] = function(player, target, ability, action)
        return useEagleEyeShot(player, target, action, 0.5)
    end,

    -- Revert enmity reduction
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
    [xi.expansion.ABYSSEA] = function(player, target, ability, action)
        return useEagleEyeShot(player, target, action, 1)
    end,
})

local scavengeData = require('modules/era/lua/data/scavenge_data')

-- Scavenge: Revert to pre-SoA zone-based item gathering and reduce duration with merits
-- Source: https://ffxiclopedia.fandom.com/wiki/Scavenge/Items
m:addOverrideByEra('xi.job_utils.ranger.useScavenge', {
    [xi.expansion.SOA] = function(player, target, ability, action)
        local meritReduction = player:getMerit(xi.merit.SCAVENGE_EFFECT)
        action:setRecast(math.max(0, action:getRecast() - meritReduction))

        -- RNG AF2 quest check
        if xi.job_utils.ranger.tryScavengeQuestItem(player) then
            return 0
        end

        local playerID = target:getID()
        local zonePool = scavengeData.zonePoolMap[player:getZoneID()]

        -- Zone has no scavenge pool, return nothing
        if not zonePool then
            action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_NOTHING)

            return 0
        end

        -- Anti-camping check: must move at least 2 yalms from last Scavenge position
        local curX  = math.floor(player:getXPos())
        local curZ  = math.floor(player:getZPos())
        local lastX = player:getLocalVar('[Scavenge]LastX')
        local lastZ = player:getLocalVar('[Scavenge]LastZ')
        player:setLocalVar('[Scavenge]LastX', curX)
        player:setLocalVar('[Scavenge]LastZ', curZ)

        if lastX > 0 then
            local lastPos = { x = lastX, y = 0, z = lastZ }
            local curPos  = { x = curX,  y = 0, z = curZ }

            if utils.distanceWithin(lastPos, curPos, 2, true) then
                action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_NOTHING)

                return 0
            end
        end

        -- Success rate check
        if math.randomInt(1, 100) > 25 + player:getMod(xi.mod.SCAVENGE_EFFECT) then
            action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_NOTHING)

            return 0
        end

        -- Build item pool from zone-specific and guaranteed items
        local itemPool = {}

        for _, v in pairs(zonePool) do
            itemPool[#itemPool + 1] = v
        end

        itemPool[#itemPool + 1] = scavengeData.guaranteedItems[math.randomInt(1, #scavengeData.guaranteedItems)]

        local selectedItem = itemPool[math.randomInt(1, #itemPool)]

        if player:addItem(selectedItem) then
            action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_ITEM)

            return selectedItem
        end

        action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_NOTHING)

        return 0
    end,
})

-- Flashy Shot: Apply merit recast reduction
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.job_utils.ranger.useFlashyShot', {
    [xi.expansion.ABYSSEA] = function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.FLASHY_SHOT) - 150
        action:setRecast(action:getRecast() - recastReduction)

        player:addStatusEffect(xi.effect.FLASHY_SHOT, { power = 1, duration = 60, origin = player })

        return xi.effect.FLASHY_SHOT
    end,
})

-- Flashy Shot Effect: Add level correction bypass
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.effects.flashy_shot.onEffectGain', {
    [xi.expansion.ABYSSEA] = function(target, effect)
        effect:addMod(xi.mod.ENMITY, 50)
        effect:addMod(xi.mod.RA_IGNORE_LVL_DIFF, 1)
    end,
})

-- Camouflage: Remove reduced enmity and chance to retain after ranged attack
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.effects.camouflage.onEffectGain', {
    [xi.expansion.WOTG] = function(target, effect)
    end,
})

-- Unlimited Shot: In WotG era, removed on any ranged attack, not just successful hits
-- TODO: find a patch note or source for this change
m:addOverrideByEra('xi.effects.unlimited_shot.onEffectGain', {
    [xi.expansion.WOTG] = function(target, effect)
    end,
})
