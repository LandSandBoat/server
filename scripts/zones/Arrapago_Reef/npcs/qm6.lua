-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (H-10 / COR boat)
-- Involved in Quests: "Luck of the Draw", "Equipped for All Occasions", "Navigating the Unfriendly Seas"
-- !pos 468.767 -12.292 111.817 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local mJob   = player:getMainJob()
    local mLvl   = player:getMainLvl()
    local lotdCS = player:getCharVar("LuckOfTheDraw")
    local efao   = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
    local efaoCS = player:getCharVar("EquippedforAllOccasions")
    local ntus   = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)

    -- LUCK OF THE DRAW
    if lotdCS == 2 then
        player:startEvent(211)

    -- EQUIPPED FOR ALL OCCASIONS
    elseif efao == QUEST_AVAILABLE and mJob == tpz.job.COR and mLvl >= AF1_QUEST_LEVEL then
        player:startEvent(228)
    elseif efao == QUEST_ACCEPTED and efaoCS == 3 then
        player:startEvent(231)

    -- NAVIGATING THE UNFRIENDLY SEAS
    elseif efao == QUEST_COMPLETED and ntus == QUEST_AVAILABLE and mJob == tpz.job.COR and mLvl >= AF2_QUEST_LEVEL then
        player:startEvent(232)
    elseif player:getCharVar("NavigatingtheUnfriendlySeas") == 4 then
        player:startEvent(233)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- LUCK OF THE DRAW
    if csid == 211 then
        player:setCharVar("LuckOfTheDraw", 3)

    -- EQUIPPED FOR ALL OCCASIONS
    elseif csid == 228 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
        player:setCharVar("EquippedforAllOccasions", 1)
    elseif csid == 231 then
        player:delKeyItem(tpz.ki.WHEEL_LOCK_TRIGGER)
        player:setCharVar("EquippedforAllOccasions", 4)

    -- NAVIGATING THE UNFRIENDLY SEAS
    elseif csid == 232 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS)
        player:setCharVar("NavigatingtheUnfriendlySeas", 1)
    elseif csid == 233 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS, {item=15601, var={"NavigatingtheUnfriendlySeas", "HydrogauageTimer"}})
    end
end
