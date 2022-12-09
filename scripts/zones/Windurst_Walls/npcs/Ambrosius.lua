-----------------------------------
-- Area: Windurst Walls
--  NPC: Ambrosius
-----------------------------------
-- Quest NPC for "The Postman Always KOs Twice"
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local postman = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)

    if postman == QUEST_AVAILABLE then
        player:startEvent(48)
    elseif postman == QUEST_ACCEPTED then
        player:startEvent(49)
    elseif postman == QUEST_COMPLETED then
        player:startEvent(56)
    end
end

entity.onTrade = function(player, npc, trade)
    local postman = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)

    if postman ~= QUEST_AVAILABLE then
        local reward = 0

        -- TODO: Table this on converting to Interaction
        if trade:hasItemQty(584, 1) then
            reward = reward + 1
        end

        if trade:hasItemQty(585, 1) then
            reward = reward + 1
        end

        if trade:hasItemQty(586, 1) then
            reward = reward + 1
        end

        if trade:hasItemQty(587, 1) then
            reward = reward + 1
        end

        if trade:getItemCount() == reward then
            if reward == 1 then
                if postman == QUEST_ACCEPTED then
                    player:startEvent(52, xi.settings.main.GIL_RATE * 50)
                elseif postman == QUEST_COMPLETED then
                    player:startEvent(57, xi.settings.main.GIL_RATE * 50)
                end
            elseif reward == 2 then
                if postman == QUEST_ACCEPTED then
                    player:startEvent(53, xi.settings.main.GIL_RATE * 150, 2)
                elseif postman == QUEST_COMPLETED then
                    player:startEvent(58, xi.settings.main.GIL_RATE * 150, 2)
                end
            elseif reward == 3 then
                if postman == QUEST_ACCEPTED then
                    player:startEvent(54, xi.settings.main.GIL_RATE * 250, 3)
                elseif postman == QUEST_COMPLETED then
                    player:startEvent(59, xi.settings.main.GIL_RATE * 250, 3)
                end
            elseif reward == 4 then
                if postman == QUEST_ACCEPTED then
                    player:startEvent(55, xi.settings.main.GIL_RATE * 500, 4)
                elseif postman == QUEST_COMPLETED then
                    player:startEvent(60, xi.settings.main.GIL_RATE * 500, 4)
                end
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 48 and option == 0 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif csid == 52 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 50)
        player:addFame(xi.quest.fame_area.WINDURST, 80)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif csid == 53 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 150)
        player:addFame(xi.quest.fame_area.WINDURST, 80)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif csid == 54 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 250)
        player:addFame(xi.quest.fame_area.WINDURST, 80)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif csid == 55 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 500)
        player:addFame(xi.quest.fame_area.WINDURST, 80)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    elseif csid == 57 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 50)
        player:addFame(xi.quest.fame_area.WINDURST, 5)
    elseif csid == 58 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 150)
        player:addFame(xi.quest.fame_area.WINDURST, 15)
    elseif csid == 59 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 250)
        player:addFame(xi.quest.fame_area.WINDURST, 25)
    elseif csid == 60 then
        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 500)
        player:addFame(xi.quest.fame_area.WINDURST, 50)
    end
end

return entity
