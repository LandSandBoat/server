-----------------------------------
-- Module: Job Adjustments (Seekers of Adoulin era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the SoA era
-----------------------------------
require('modules/module_utils')
local scavengeData = require('modules/soa/lua/scavenge_data')
-----------------------------------
local m = Module:new('soa_job_adjustments')

-----------------------------------
-- Dark Knight
-----------------------------------

-- Last Resort: Reduces attack bonus from 25% to 15%
-- Source: https://forum.square-enix.com/ffxi/threads/46976-May-14-2015-%28JST%29-Version-Update
m:addOverride('xi.effects.last_resort.onEffectGain', function(target, effect)
    local targetMerit = target:getMerit(xi.merit.LAST_RESORT_EFFECT)

    effect:addMod(xi.mod.ATTP, 15 + targetMerit)
    effect:addMod(xi.mod.RATTP, 15 + targetMerit)
    effect:addMod(xi.mod.DEFP, -15 - targetMerit)
    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))
end)

-----------------------------------
-- Ranger
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
-----------------------------------

-- Scavenge: Revert to pre-SoA zone-based item gathering and reduce duration with merits
-- Source: https://ffxiclopedia.fandom.com/wiki/Scavenge/Items
m:addOverride('xi.job_utils.ranger.useScavenge', function(player, target, ability, action)
    local meritReduction = player:getMerit(xi.merit.SCAVENGE_EFFECT)
    ability:setRecast(ability:getRecast() - meritReduction)

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
    if math.random(1, 100) > 25 + player:getMod(xi.mod.SCAVENGE_EFFECT) then
        action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_NOTHING)

        return 0
    end

    -- Build item pool from zone-specific and guaranteed items
    local itemPool = {}

    for _, v in pairs(zonePool) do
        itemPool[#itemPool + 1] = v
    end

    itemPool[#itemPool + 1] = scavengeData.guaranteedItems[math.random(1, #scavengeData.guaranteedItems)]

    local selectedItem = itemPool[math.random(1, #itemPool)]

    if player:addItem(selectedItem) then
        action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_ITEM)

        return selectedItem
    end

    action:messageID(playerID, xi.msg.basic.SCAVENGE_FIND_NOTHING)

    return 0
end)

-----------------------------------
-- Ninja
-----------------------------------

-- Sange: Reverts to Utsusemi based barrage style ranged attack
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
m:addOverride('xi.job_utils.ninja.useSange', function(player, target, ability, action)
    local meritReduction = player:getMerit(xi.merit.SANGE) - 150
    ability:setRecast(math.max(0, ability:getRecast() - meritReduction))

    -- Apply Sange effect (shadows are consumed when the ranged attack fires)
    player:addStatusEffect(xi.effect.SANGE, 0, 0, 60)

    return xi.effect.SANGE
end)

-- Sange effect: Replace 100% daken with multi-hit ranged mod
m:addOverride('xi.effects.sange.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.SANGE_MULTI_HIT, 1)
end)

-- TODO: Detection Spell Durations
-- Source: https://forum.square-enix.com/ffxi/threads/39564-Jan-21-2014-%28JST%29-Version-Update
--   Tonko Ichi:  420 seconds -> 180 seconds
--   Tonko Ni:    600 seconds -> 300 seconds
--   Monomi Ichi: 420 seconds -> 180 seconds

return m
