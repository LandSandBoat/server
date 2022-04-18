-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Waoud
-- Standard Info NPC
-- Involved in quests: An Empty Vessel (BLU Unlock), Beginnings (BLU AF Quest 1), Omens (BLU AF Quest 2)
-- !pos 65 -6 -78 50
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local divinationReady = vanaDay() > player:getCharVar("LastDivinationDay")
    local beginnings = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)
    local omens = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS)
    local transformations = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS)
    local transformationsProgress = player:getCharVar("TransformationsProgress")
    local currentJob = player:getMainJob()
    local waoudNeedToZone = player:getLocalVar("WaoudNeedToZone")

    -- OMENS
    if beginnings == QUEST_COMPLETED and omens == QUEST_AVAILABLE and currentJob == xi.job.BLU and player:getMainLvl() >= xi.settings.AF2_QUEST_LEVEL then
        if divinationReady then
            if waoudNeedToZone == 1 then
                player:startEvent(78, player:getGil()) -- dummy questions, costs you 1000 gil
            else
                player:startEvent(710) -- start Omens
            end
        else
            player:startEvent(63)
        end
    elseif omens == QUEST_ACCEPTED then
        if player:getCharVar("OmensProgress") == 1 then
            player:startEvent(711, player:getGil()) -- clue about bcnm location, costs you 1000 gil
        elseif player:getCharVar("OmensProgress") == 2 then
            player:startEvent(712) -- gives keyitem to claim armour piece
        elseif player:getCharVar("OmensProgress") >= 3 then
            player:startEvent(713, player:getGil()) -- clue about location of armour piece, costs you 1000 gil
        end

    -- TRANSFORMATIONS
    elseif omens == QUEST_COMPLETED and transformations == QUEST_AVAILABLE and currentJob == xi.job.BLU then
        if divinationReady then
            if waoudNeedToZone == 1 then
                player:startEvent(78, player:getGil()) -- dummy questions, costs you 1000 gil
            elseif transformationsProgress == 1 then
                player:startEvent(721, player:getGil())
            else
                player:startEvent(720, player:getGil()) -- starts Transformations
            end
        else
            player:startEvent(63)
        end
    elseif transformations == QUEST_ACCEPTED then
        player:startEvent(723, player:getGil()) -- clue about possible route to take, costs you 1000 gil
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local beginnings = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)
    local omensProgress = player:getCharVar("OmensProgress")
    local transformationsProgress = player:getCharVar("TransformationsProgress")

    -- OMENS
    if csid == 710 and beginnings == QUEST_COMPLETED then
        player:addQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS)
        player:setCharVar("OmensProgress", 1)
    elseif csid == 711 and option == 1 and omensProgress == 1 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 712 and omensProgress == 2 then
        npcUtil.giveKeyItem(player, xi.ki.SEALED_IMMORTAL_ENVELOPE)
        player:setCharVar("OmensProgress", 3)
    elseif csid == 713 and option == 1 and omensProgress == 3 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.

    -- TRANSFORMATIONS
    elseif (csid == 720 or csid == 721) and option == 1 and player:getGil() >= 1000 then
        if csid == 720 then
            player:setCharVar("TransformationsProgress", 1)
        end
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 723 and option == 1 and transformationsProgress == 2 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    end
end

return entity
