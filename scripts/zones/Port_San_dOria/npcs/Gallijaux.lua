-----------------------------------
-- Area: Port San d'Oria
--  NPC: Gallijaux
--  Starts The Rivalry
-- !pos -14 -2 -45 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.fishingAnimation(npc, 2)
end

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local moatCarp = trade:getItemQty(4401)
    local forestCarp = trade:getItemQty(4289)
    local fishCountVar = player:getCharVar("theCompetitionFishCountVar")
    local totalFish = moatCarp + forestCarp + fishCountVar

    if moatCarp + forestCarp > 0 and moatCarp + forestCarp == count then
        if
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_ACCEPTED and
            totalFish >= 10000
        then
            -- ultimate reward
            player:tradeComplete()
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            npcUtil.giveCurrency(player, 'gil', moatCarp * 10 + forestCarp * 15)
            player:startEvent(303)
        elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) >= QUEST_ACCEPTED then -- regular turn-ins. Still allowed after completion of the quest.
            player:tradeComplete()
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:setCharVar("theCompetitionFishCountVar", totalFish)
            player:startEvent(301)
            npcUtil.giveCurrency(player, 'gil', moatCarp * 10 + forestCarp * 15)
        else
            player:startEvent(302)
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_AVAILABLE and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_AVAILABLE
    then
        -- If you haven't started either quest yet
        player:startEvent(300, 4401, 4289) -- 4401 = Moat Carp, 4289 = Forest Carp
    elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.GALLIJAUX_CARP_STATUS, 0, player:getCharVar("theCompetitionFishCountVar"))
    elseif player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == QUEST_ACCEPTED then
        player:showText(npc, ID.text.GALLIJAUX_HELP_OTHER_BROTHER)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 303 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17386)
        else
            player:tradeComplete()
            player:addItem(17386)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17386)
            player:addTitle(xi.title.CARP_DIEM)
            player:addKeyItem(xi.ki.TESTIMONIAL)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TESTIMONIAL)
            player:setCharVar("theCompetitionFishCountVar", 0)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY)
        end
    elseif csid == 300 and option == 700 then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY)
    end
end

return entity
