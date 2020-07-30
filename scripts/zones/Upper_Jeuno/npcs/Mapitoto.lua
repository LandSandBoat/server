-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mapitoto
-- Type: Full Speed Ahead Mount NPC
-- !pos -54.310 8.200 85.940 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/chocobo")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    -- The Fenrir (10057) and Omega (10067) items and mounts have their own questlines, so they aren't valid trades here
    if trade:getSlotCount() == 1 and not (npcUtil.tradeHasExactly(trade, 10057) or npcUtil.tradeHasExactly(trade, 10067)) then
        local item = trade:getItemId(0)
        local mount = item - 10050
        if item == 15533 then
            player:startEvent(10227, 15533, tpz.ki.TRAINERS_WHISTLE, tpz.mount.CHOCOBO)
            player:setLocalVar("FullSpeedAheadReward", tpz.ki.CHOCOBO_COMPANION)
        elseif mount >= 0 and mount <= 24 then
            player:setLocalVar("FullSpeedAheadReward", tpz.ki.TIGER_COMPANION + mount)
            player:startEvent(10227, item, tpz.ki.TRAINERS_WHISTLE, tpz.mount.TIGER + mount - 1)
        end
    end
end

function onTrigger(player, npc)
    -- Minigame complete
    local fullSpeedAheadStatus = player:getCharVar("[QUEST]FullSpeedAhead")
    local hasTrainersWhistle = player:hasKeyItem(tpz.ki.TRAINERS_WHISTLE)

    if hasTrainersWhistle then
        player:startEvent(10226)
    elseif
      player:hasKeyItem(tpz.ki.CHOCOBO_LICENSE) and
      player:getMainLvl() >= 20 and
      player:hasKeyItem(tpz.ki.MAP_OF_THE_JEUNO_AREA)
    then
        player:startEvent(10223, 0, 0, 4)
    elseif fullSpeedAheadStatus == 1 then
        player:startEvent(10225, tpz.ki.TRAINERS_WHISTLE)
    else
        player:startEvent(10222)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10223 and option == 1 then
        player:setPos(475, 8.8, -159, 128, 105)
    elseif csid == 10225 then
        -- Complete quest
        npcUtil.giveKeyItem(player, tpz.ki.TRAINERS_WHISTLE)
        npcUtil.giveKeyItem(player, tpz.ki.RAPTOR_COMPANION)
    elseif csid == 10227 then
        local rewardKI = player:getLocalVar("FullSpeedAheadReward")
        player:setLocalVar("FullSpeedAheadReward", 0)
        if rewardKI ~= tpz.ki.CHOCOBO_COMPANION then
            player:tradeComplete()
        end
        npcUtil.giveKeyItem(player, rewardKI)
    end
end
