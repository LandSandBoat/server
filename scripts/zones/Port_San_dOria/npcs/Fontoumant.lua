-----------------------------------
-- Area: Port San d'Oria
--  NPC: Fontoumant
-- Starts Quest: The Brugaire Consortium
-- Involved in Quests: Riding on the Clouds
-- !pos -10 -10 -122 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local count = trade:getItemCount()
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_ACCEPTED) then
        if (count == 1 and trade:getGil() == 100) then  -- pay to replace package
            local prog = player:getCharVar("TheBrugaireConsortium-Parcels")
            if (prog == 10 and player:hasItem(593) == false) then
                player:startEvent(608)
                player:setCharVar("TheBrugaireConsortium-Parcels", 11)
            elseif (prog == 20 and player:hasItem(594) == false) then
                player:startEvent(609)
                player:setCharVar("TheBrugaireConsortium-Parcels", 21)
            elseif (prog == 30 and player:hasItem(595) == false) then
                player:startEvent(610)
                player:setCharVar("TheBrugaireConsortium-Parcels", 31)
            end
        end
    end

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS) == QUEST_ACCEPTED and player:getCharVar("ridingOnTheClouds_1") == 6) then
        if (trade:hasItemQty(1127, 1) and count == 1) then -- Trade Kindred seal
            player:setCharVar("ridingOnTheClouds_1", 0)
            player:tradeComplete()
            player:addKeyItem(tpz.ki.SCOWLING_STONE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SCOWLING_STONE)
        end
    end

end

function onTrigger(player, npc)

    local TheBrugaireConsortium = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)

    if (TheBrugaireConsortium == QUEST_AVAILABLE) then
        player:startEvent(509)
    elseif (TheBrugaireConsortium == QUEST_ACCEPTED) then

        local prog = player:getCharVar("TheBrugaireConsortium-Parcels")
        if (prog == 11) then
            player:startEvent(511)
        elseif (prog == 21) then
            player:startEvent(512)
        elseif (prog == 31) then
            player:startEvent(515)
        else
            player:startEvent(560)
        end
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local freeSlots = player:getFreeSlotsCount()
    if (csid == 509 and option == 0) then
        if (freeSlots ~= 0) then
            player:addItem(593)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 593)
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)
            player:setCharVar("TheBrugaireConsortium-Parcels", 10)
        else
            player:startEvent(537)
        end
    elseif (csid == 511) then
        if (freeSlots ~= 0) then
            player:addItem(594)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 594)
            player:setCharVar("TheBrugaireConsortium-Parcels", 20)
        else
            player:startEvent(537)
        end
    elseif (csid == 512) then
        if (freeSlots ~= 0) then
            player:addItem(595)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 595)
            player:setCharVar("TheBrugaireConsortium-Parcels", 30)
        else
            player:startEvent(537)
        end
    elseif (csid == 608 or csid == 609 or csid == 610) then
        player:tradeComplete()
    elseif (csid == 515) then
        if (freeSlots ~= 0) then
            player:addItem(12289)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12289)
            player:addTitle(tpz.title.COURIER_EXTRAORDINAIRE)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)
            player:addFame(SANDORIA, 30)
            player:setCharVar("TheBrugaireConsortium-Parcels", 0)
        else
            player:startEvent(537)
        end
    end

end
