-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Green Bobble)
-- Type: Magian Trials NPC (Job Emotes)
-- !pos -4.558 2.451 111.305 64
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/magiantrials")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1) then
        local ItemID = trade:getItemId()
        local TrialInfo = getEmoteTrialInfo(ItemID)
        local invalid = 0
        if (TrialInfo.t1 == 0 and TrialInfo.t2 == 0 and TrialInfo.t3 == 0 and TrialInfo.t4 == 0) then
            invalid = 1
        end
        player:startEvent(10153, TrialInfo.t1, TrialInfo.t2, TrialInfo.t3, TrialInfo.t4, 0, ItemID, 0, invalid)
    else
        -- placeholder for torque+other required item trade.
    end
end

function onTrigger(player, npc)
    local LearnerLog = player:hasKeyItem(tpz.ki.MAGIAN_LEARNERS_LOG)
    local TrialLog = player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG)
    if (player:getMainLvl() < 30) then
        player:startEvent(10151)
    elseif (player:getCharVar("MetGreenMagianMog") == 0 and LearnerLog == false) then
        if (TrialLog == false) then
            player:startEvent(10160, 0)
        else
            player:startEvent(10160, 1)
        end
    else
        player:startEvent(10152) -- parameters unknown
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10160 and option == 1) then
        if (player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) == false) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAGIAN_LEARNERS_LOG)
            player:addKeyItem(tpz.ki.MAGIAN_LEARNERS_LOG)
        end
        player:setCharVar("MetGreenMagianMog", 1)
    --elseif
        --
    end
end
