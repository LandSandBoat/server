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
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM) == QUEST_ACCEPTED then
        if count == 1 and trade:getGil() == 100 then  -- pay to replace package
            local prog = player:getCharVar("TheBrugaireConsortium-Parcels")
            if prog == 10 and not player:hasItem(593) then
                player:startEvent(608)
                player:setCharVar("TheBrugaireConsortium-Parcels", 11)
            elseif prog == 20 and not player:hasItem(594) then
                player:startEvent(609)
                player:setCharVar("TheBrugaireConsortium-Parcels", 21)
            elseif prog == 30 and not player:hasItem(595) then
                player:startEvent(610)
                player:setCharVar("TheBrugaireConsortium-Parcels", 31)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local theBrugaireConsortium = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)

    if theBrugaireConsortium == QUEST_AVAILABLE then
        player:startEvent(509)
    elseif theBrugaireConsortium == QUEST_ACCEPTED then
        local prog = player:getCharVar("TheBrugaireConsortium-Parcels")

        if prog == 11 then
            player:startEvent(511)
        elseif prog == 21 then
            player:startEvent(512)
        elseif prog == 31 then
            player:startEvent(515)
        else
            player:startEvent(560)
        end

    -- post-quest default dialog
    else
        player:startEvent(561)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local freeSlots = player:getFreeSlotsCount()
    if csid == 509 and option == 0 then
        if freeSlots ~= 0 then
            player:addItem(593)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 593)
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)
            player:setCharVar("TheBrugaireConsortium-Parcels", 10)
        else
            player:startEvent(537)
        end
    elseif csid == 511 then
        if freeSlots ~= 0 then
            player:addItem(594)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 594)
            player:setCharVar("TheBrugaireConsortium-Parcels", 20)
        else
            player:startEvent(537)
        end
    elseif csid == 512 then
        if freeSlots ~= 0 then
            player:addItem(595)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 595)
            player:setCharVar("TheBrugaireConsortium-Parcels", 30)
        else
            player:startEvent(537)
        end
    elseif csid == 608 or csid == 609 or csid == 610 then
        player:tradeComplete()
    elseif csid == 515 then
        if freeSlots ~= 0 then
            player:addItem(12289)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 12289)
            player:addTitle(xi.title.COURIER_EXTRAORDINAIRE)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:setCharVar("TheBrugaireConsortium-Parcels", 0)
        else
            player:startEvent(537)
        end
    end
end

return entity
