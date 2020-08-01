-----------------------------------
-- Area: Windurst Waters
--  NPC: Angelica
-- Starts and Finished Quest: A Pose By Any Other Name
-- !pos -70 -10 -6 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    posestatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
    if (posestatus == QUEST_AVAILABLE and player:getCharVar("QuestAPoseByOtherName_prog") == 0 and player:needToZone() == false) then
        player:startEvent(87)                                                     -- A POSE BY ANY tpz.nation.OTHER NAME: Before Quest
        player:setCharVar("QuestAPoseByOtherName_prog", 1)
    elseif (posestatus == QUEST_AVAILABLE and player:getCharVar("QuestAPoseByOtherName_prog") == 1) then
        player:setCharVar("QuestAPoseByOtherName_prog", 2)
        mjob = player:getMainJob()
        if (mjob == tpz.job.WAR or mjob == tpz.job.PLD or mjob == tpz.job.DRK or mjob == tpz.job.DRG or mjob == tpz.job.COR) then      -- Quest Start: Bronze Harness (War/Pld/Drk/Drg/Crs)
            player:startEvent(92, 0, 0, 0, 12576)
            player:setCharVar("QuestAPoseByOtherName_equip", 12576)
        elseif (mjob == tpz.job.MNK or mjob == tpz.job.BRD or mjob == tpz.job.BLU) then                             -- Quest Start: Robe (Mnk/Brd/Blu)
            player:startEvent(92, 0, 0, 0, 12600)
            player:setCharVar("QuestAPoseByOtherName_equip", 12600)
        elseif (mjob == tpz.job.THF or mjob == tpz.job.BST or mjob == tpz.job.RNG or mjob == tpz.job.DNC) then             -- Quest Start: Leather Vest (Thf/Bst/Rng/Dnc)
            player:startEvent(92, 0, 0, 0, 12568)
            player:setCharVar("QuestAPoseByOtherName_equip", 12568)
        elseif (mjob == tpz.job.WHM or mjob == tpz.job.BLM or mjob == tpz.job.SMN or mjob == tpz.job.PUP or mjob == tpz.job.SCH) then     -- Quest Start: Tunic (Whm/Blm/Rdm/Smn/Pup/Sch)
            player:startEvent(92, 0, 0, 0, 12608)
            player:setCharVar("QuestAPoseByOtherName_equip", 12608)
        elseif (mjob == tpz.job.SAM or mjob == tpz.job.NIN) then                                         -- Quest Start: Kenpogi(Sam/Nin)
            player:startEvent(92, 0, 0, 0, 12584)
            player:setCharVar("QuestAPoseByOtherName_equip", 12584)
        end
    elseif (posestatus == QUEST_ACCEPTED) then
        starttime = player:getCharVar("QuestAPoseByOtherName_time")
        if ((starttime + 600) >= os.time()) then
            if (player:getEquipID(tpz.slot.BODY) == player:getCharVar("QuestAPoseByOtherName_equip")) then
                player:startEvent(96)     ------------------------------------------  QUEST FINISH
            else
                player:startEvent(93, 0, 0, 0, player:getCharVar("QuestAPoseByOtherName_equip"))-- QUEST REMINDER
            end
        else
            player:startEvent(102)     ------------------------------------------  QUEST FAILURE
        end
    elseif (posestatus == QUEST_COMPLETED and player:needToZone()) then
        player:startEvent(101) -----------------------------------------------    AFTER QUEST
    else
        rand = math.random(1, 3)
        if (rand == 1) then
            player:startEvent(86) -------------------------------------------- Standard Conversation 1
        elseif (rand == 2) then
            player:startEvent(88) -------------------------------------------- Standard Conversation 2
        else
            player:startEvent(89) -------------------------------------------- Standard Conversation 3
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 92) then -------------------------- QUEST START
        player:addQuest(WINDURST, tpz.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
        player:setCharVar("QuestAPoseByOtherName_time", os.time())
    elseif (csid == 96) then  --------------------- QUEST FINFISH
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 206)
        else
            player:completeQuest(WINDURST, tpz.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
            player:addTitle(tpz.title.SUPER_MODEL)
            player:addItem(206)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 206)
            player:addKeyItem(tpz.ki.ANGELICAS_AUTOGRAPH)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ANGELICAS_AUTOGRAPH)
            player:addFame(WINDURST, 75)
            player:setCharVar("QuestAPoseByOtherName_time", 0)
            player:setCharVar("QuestAPoseByOtherName_equip", 0)
            player:setCharVar("QuestAPoseByOtherName_prog", 0)
            player:needToZone(true)
        end
    elseif (csid == 102) then  ---------------------- QUEST FAILURE
        player:delQuest(WINDURST, tpz.quest.id.windurst.A_POSE_BY_ANY_OTHER_NAME)
        player:addTitle(tpz.title.LOWER_THAN_THE_LOWEST_TUNNEL_WORM)
        player:setCharVar("QuestAPoseByOtherName_time", 0)
        player:setCharVar("QuestAPoseByOtherName_equip", 0)
        player:setCharVar("QuestAPoseByOtherName_prog", 0)
        player:needToZone(true)
    end
end
