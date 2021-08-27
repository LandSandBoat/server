-----------------------------------
-- Area: Windurst Waters
--  NPC: Honoi-Gumoi
-- Involved In Quest: Crying Over Onions, Hat in Hand
-- !pos -195 -11 -120 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade "Star Spinel" for "Crying over Onions" after having talked to this NPC once
    -- and optionally talked to Nanaa Mihgo (CryingOverOnions == 2)
    if
        (player:getCharVar("CryingOverOnions") == 1 or player:getCharVar("CryingOverOnions") == 2) and
        npcUtil.tradeHas(trade, xi.items.STAR_SPINEL)
    then
        player:startEvent(775, 0, xi.items.STAR_SPINEL)
    end
end

entity.onTrigger = function(player, npc)
    local cryingOverOnions  = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    local wildCard          = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WILD_CARD)

    if
        player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and
        player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") == 5
    then
        player:startEvent(874) -- COP event
    elseif player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and not utils.mask.getBit(player:getCharVar("QuestHatInHand_var"), 1) then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(59)
    elseif wildCard == QUEST_ACCEPTED then
        if player:getCharVar("WildCard") == 3 and not player:hasKeyItem(xi.ki.JOKER_CARD) then
            player:startEvent(782)
        else
            player:startEvent(781)
        end
    elseif cryingOverOnions == QUEST_ACCEPTED then
        local cryingOverOnionsVar = player:getCharVar("CryingOverOnions")

        if cryingOverOnionsVar == 4 then
            player:startEvent(776)
        elseif cryingOverOnionsVar == 3 then
            player:startEvent(778)
        elseif cryingOverOnionsVar >= 1 then
            player:startEvent(777)
        else
            player:startEvent(774, 0, xi.items.STAR_SPINEL)
        end
    elseif wildCard == QUEST_COMPLETED then
        player:startEvent(783)
    elseif cryingOverOnions == QUEST_COMPLETED then
        if not player:needToZone() and player:getFameLevel(WINDURST) >= 6 then
            player:startEvent(780)
        else
            player:startEvent(779)
        end
    else
        player:startEvent(650)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    -- "Crying over Onions"
    if csid == 774 then
        player:setCharVar("CryingOverOnions", 1)
    elseif csid == 775 and npcUtil.giveItem(player, xi.items.STAR_NECKLACE) then
        player:confirmTrade()
        player:setCharVar("CryingOverOnions", 3)
    elseif
        csid == 776 and
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS, {
            fame = 120,
            var = "CryingOverOnions",
        })
    then
        player:needToZone(true)

    -- "Wild Card"
    elseif csid == 780 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WILD_CARD)
    elseif
        csid == 782 and
        npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.WILD_CARD, {
            title = xi.title.DREAM_DWELLER,
            fame = 135,
            var = "WildCard",
        })
    then
        player:needToZone(true)

    -- "Hat in Hand"
    elseif csid == 59 then
        player:setCharVar("QuestHatInHand_var", utils.mask.setBit(player:getCharVar("QuestHatInHand_var"), 1, true))
        player:addCharVar("QuestHatInHand_count", 1)

    -- COP Misson 3-3B "Memories of a Maiden"
    elseif csid == 874 then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 6)
        npcUtil.giveKeyItem(player, xi.ki.CRACKED_MIMEO_MIRROR)
    end
end

return entity
