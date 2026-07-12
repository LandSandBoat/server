-----------------------------------
-- Module: Ranger Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_ranger'
local m = Module:new(moduleName)

-- Register RoV reverts only before RoV content is enabled.
if not xi.module.isContentEnabled('ROV') then
    -- Eagle Eye Shot: Revert shadow bypass
    -- Source: https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
    m:addOverride('xi.job_utils.ranger.useEagleEyeShot', function(player, target, ability, action)
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

        params.enmityMult = 0.5

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
    end)
end

-- Register SoA reverts only before SoA content is enabled.
if not xi.module.isContentEnabled('SOA') then
    local scavengeData = require('modules/era/lua/data/scavenge_data')

    -- Scavenge: Revert to pre-SoA zone-based item gathering and reduce duration with merits
    -- Source: https://ffxiclopedia.fandom.com/wiki/Scavenge/Items
    m:addOverride('xi.job_utils.ranger.useScavenge', function(player, target, ability, action)
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
    end)
end

-- Register Abyssea reverts only before Abyssea content is enabled.
if not xi.module.isContentEnabled('ABYSSEA') then
    -- Flashy Shot: Apply merit recast reduction
    m:addOverride('xi.job_utils.ranger.useFlashyShot', function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.FLASHY_SHOT) - 150
        action:setRecast(action:getRecast() - recastReduction)

        player:addStatusEffect(xi.effect.FLASHY_SHOT, { power = 1, duration = 60, origin = player })

        return xi.effect.FLASHY_SHOT
    end)

    -- Flashy Shot Effect: Add level correction bypass
    m:addOverride('xi.effects.flashy_shot.onEffectGain', function(target, effect)
        effect:addMod(xi.mod.ENMITY, 50)
        effect:addMod(xi.mod.RA_IGNORE_LVL_DIFF, 1)
    end)
end

-- Register WOTG reverts only before WOTG content is enabled.
if not xi.module.isContentEnabled('WOTG') then
    -- Camouflage: Remove reduced enmity and chance to retain after ranged attack
    m:addOverride('xi.effects.camouflage.onEffectGain', function(target, effect)
    end)

    -- Unlimited Shot: In WotG era, removed on any ranged attack, not just successful hits
    m:addOverride('xi.effects.unlimited_shot.onEffectGain', function(target, effect)
    end)
end

-- Return a real module only when a content gate registered overrides.
-- Otherwise return a data-only table to avoid a "No overrides found" loader warning.
if #m.overrides > 0 then
    return m
end

return { name = moduleName }
