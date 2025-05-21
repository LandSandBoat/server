-----------------------------------
-- Area: Windurst Waters
--  NPC: Ohbiru-Dohbiru
-- Involved in quest: Food For Thought, Say It with Flowers
--  Starts and finishes quest: Toraimarai Turmoil
-- !pos 23 -5 -193 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local needToZone = player:needToZone()
    local sayFlowers = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SAY_IT_WITH_FLOWERS)
    local flowerProgress = player:getCharVar('FLOWER_PROGRESS')

    if
        (sayFlowers == xi.questStatus.QUEST_ACCEPTED or sayFlowers == xi.questStatus.QUEST_COMPLETED) and
        flowerProgress == 1
    then
        if needToZone then
            player:startEvent(518)
        elseif player:getCharVar('FLOWER_PROGRESS') == 2 then
            player:startEvent(517, 0, 0, 0, 0, 950)
        else
            player:startEvent(516, 0, 0, 0, 0, 950)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local flowerList =
    {
        [0] = { itemid = 948, gil = 300 }, -- Carnation
        [1] = { itemid = 941, gil = 200 }, -- Red Rose
        [2] = { itemid = 949, gil = 250 }, -- Rain Lily
        [3] = { itemid = 956, gil = 150 }, -- Lilac
        [4] = { itemid = 957, gil = 200 }, -- Amaryllis
        [5] = { itemid = 958, gil = 100 }  -- Marguerite
    }

    if csid == 516 then
        if option < 7 then
            local choice = flowerList[option]
            if choice and player:getGil() >= choice.gil then
                if player:getFreeSlotsCount() > 0 then
                    player:addItem(choice.itemid)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, choice.itemid)
                    player:delGil(choice.gil)
                    player:needToZone(true)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, choice.itemid)
                end
            else
                player:messageSpecial(ID.text.NOT_HAVE_ENOUGH_GIL)
            end
        elseif option == 7 then
            player:setCharVar('FLOWER_PROGRESS', 2)
        end
    end
end

return entity
