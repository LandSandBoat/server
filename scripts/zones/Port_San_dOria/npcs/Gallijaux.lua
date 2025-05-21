-----------------------------------
-- Area: Port San d'Oria
--  NPC: Gallijaux
--  Starts The Rivalry
-- !pos -14 -2 -45 232
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.fishingAnimation(npc, 2)
end

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local moatCarp = trade:getItemQty(xi.item.MOAT_CARP)
    local forestCarp = trade:getItemQty(xi.item.FOREST_CARP)
    local fishCountVar = player:getCharVar('theCompetitionFishCountVar')
    local totalFish = moatCarp + forestCarp + fishCountVar

    if moatCarp + forestCarp > 0 and moatCarp + forestCarp == count then
        if
            player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == xi.questStatus.QUEST_ACCEPTED and
            totalFish >= 10000
        then
            -- ultimate reward
            player:tradeComplete()
            player:addFame(xi.fameArea.SANDORIA, 30)
            npcUtil.giveCurrency(player, 'gil', moatCarp * 10 + forestCarp * 15)
            player:startEvent(303)
        elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) >= xi.questStatus.QUEST_ACCEPTED then -- regular turn-ins. Still allowed after completion of the quest.
            player:tradeComplete()
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:setCharVar('theCompetitionFishCountVar', totalFish)
            player:startEvent(301)
            npcUtil.giveCurrency(player, 'gil', moatCarp * 10 + forestCarp * 15)
        else
            player:startEvent(302)
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_AVAILABLE and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == xi.questStatus.QUEST_AVAILABLE
    then
        -- If you haven't started either quest yet
        player:startEvent(300, 4401, 4289) -- 4401 = Moat Carp, 4289 = Forest Carp
    elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == xi.questStatus.QUEST_ACCEPTED then
        player:showText(npc, ID.text.GALLIJAUX_CARP_STATUS, 0, player:getCharVar('theCompetitionFishCountVar'))
    elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_ACCEPTED then
        player:showText(npc, ID.text.GALLIJAUX_HELP_OTHER_BROTHER)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 303 then
        if npcUtil.giveItem(player, xi.item.LU_SHANGS_FISHING_ROD) then
            player:tradeComplete()
            player:addTitle(xi.title.CARP_DIEM)
            npcUtil.giveKeyItem(player, xi.ki.TESTIMONIAL)
            player:setCharVar('theCompetitionFishCountVar', 0)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY)
        end
    elseif csid == 300 and option == 700 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY)
    end
end

return entity
