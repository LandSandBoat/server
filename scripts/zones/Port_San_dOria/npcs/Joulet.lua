-----------------------------------
-- Area: Port San d'Oria
--  NPC: Joulet
--  Starts The Competition
-- !pos -18 -2 -45 232
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
            player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_ACCEPTED and
            totalFish >= 10000
        then
            -- ultimate reward
            player:tradeComplete()
            player:addFame(xi.fameArea.SANDORIA, 30)
            npcUtil.giveCurrency(player, 'gil', moatCarp * 10 + forestCarp * 15)
            player:startEvent(307)
        elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) >= xi.questStatus.QUEST_ACCEPTED then -- regular turn-ins. Still allowed after completion of the quest.
            player:tradeComplete()
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:setCharVar('theCompetitionFishCountVar', totalFish)
            player:startEvent(305)
            npcUtil.giveCurrency(player, 'gil', moatCarp * 10 + forestCarp * 15)
        else
            player:startEvent(306)
        end
    end

    npc:setAnimation(0)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_AVAILABLE and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == xi.questStatus.QUEST_AVAILABLE
    then
        -- If you haven't started either quest yet
        player:startEvent(304, 4401, 4289) -- Moat Carp = 4401, 4289 = Forest Carp
    elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_RIVALRY) == xi.questStatus.QUEST_ACCEPTED then
        player:showText(npc, ID.text.JOULET_HELP_OTHER_BROTHER)
    elseif player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION) == xi.questStatus.QUEST_ACCEPTED then
        player:showText(npc, ID.text.JOULET_CARP_STATUS, 0, player:getCharVar('theCompetitionFishCountVar'))
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 307 then
        if npcUtil.giveItem(player, xi.item.LU_SHANGS_FISHING_ROD) then
            player:tradeComplete()
            player:addTitle(xi.title.CARP_DIEM)
            npcUtil.giveKeyItem(player, xi.ki.TESTIMONIAL)
            player:setCharVar('theCompetitionFishCountVar', 0)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION)
        end
    elseif csid == 304 and option == 700 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_COMPETITION)
    end
end

return entity
