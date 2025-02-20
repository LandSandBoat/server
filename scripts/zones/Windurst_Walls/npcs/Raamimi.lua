-----------------------------------
-- Area: Windurst Walls
--  Location: X:-81  Y:-9  Z:103
--  NPC: Raamimi
--  Involved in Quest: To Bee or Not to Bee?
-----------------------------------
local ID = zones[xi.zone.WINDURST_WALLS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local toBee = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
    local toBeeOrNotStatus = player:getCharVar('ToBeeOrNot_var')

    if toBeeOrNotStatus == 10 and toBee == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(67) -- Quest Started - He gives you honey
    elseif toBee == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(68) -- After honey is given to player...... but before 5th hondy is given to Zayhi
    elseif toBee == xi.questStatus.QUEST_COMPLETED and toBeeOrNotStatus == 5 then
        player:startEvent(80) -- Quest Finish - Gives Mulsum
    elseif
        toBee == xi.questStatus.QUEST_COMPLETED and
        toBeeOrNotStatus == 0 and
        player:needToZone()
    then
        player:startEvent(79) -- After Quest but before zoning "it's certainly gotten quiet around here..."
    else
        player:startEvent(296)
    end
end

-- Event ID List for NPC
--  player:startEvent(296) -- Standard Conversation
--  player:startEvent(67) -- Quest is kicked off already, he gives you honey
-- player:startEvent(68) -- After honey is given to player...... before given to Zayhi????
--  player:startEvent(80) -- Quest Finish - Gives Mulsum
--  player:startEvent(79) -- After Quest but before zoning: "it's certainly gotten quiet around here..."

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 67 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.POT_OF_HONEY) -- Cannot give Honey because player Inventory is full
        else
            player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
            player:addItem(xi.item.POT_OF_HONEY)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.POT_OF_HONEY) -- Gives player Honey x1
        end
    elseif csid == 80 then -- After Honey#5: ToBee quest Finish (tooth hurts from all the Honey)
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4156) -- Cannot give Mulsum because player Inventory is full
        else
            player:setCharVar('ToBeeOrNot_var', 0)
            player:addItem(xi.item.BOTTLE_OF_MULSUM, 3) -- Mulsum x3
            player:messageSpecial(ID.text.ITEMS_OBTAINED, xi.item.BOTTLE_OF_MULSUM, 3)
            player:needToZone(true)
        end
    end
end

return entity
