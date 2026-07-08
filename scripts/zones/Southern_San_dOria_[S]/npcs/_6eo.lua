-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Door:House
-- !pos 148 0 27 80
-- Involved in Knot Quite There
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('KnotQuiteThere') == 3
    then
        player:startEvent(63)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 63 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.PLATINUM_BEASTCOIN)
        else
            player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.KNOT_QUITE_THERE)
            player:addItem(xi.item.PLATINUM_BEASTCOIN)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.PLATINUM_BEASTCOIN)
            player:setCharVar('KnotQuiteThere', 0)
        end
    end
end

return entity
