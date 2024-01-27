-----------------------------------
-- Area: Jugner Forest
--  NPC: Signpost
-- Involved in Quest: Grimy Signposts
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()

    if xPos > -79.3 and xPos < -67.3 and zPos > 94.5 and zPos < 106.5 then
        if
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and
            not utils.mask.getBit(player:getCharVar('CleanSignPost'), 0)
        then
            player:startEvent(6, 1)
        else
            player:startEvent(1)
        end
    elseif xPos > -266.2 and xPos < -254.2 and zPos > -29.2 and zPos < -17.2 then
        if
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and
            not utils.mask.getBit(player:getCharVar('CleanSignPost'), 1)
        then
            player:startEvent(7, 1)
        else
            player:startEvent(2)
        end
    elseif xPos > -463.7 and xPos < -451.7 and zPos > -422.1 and zPos < -410.1 then
        if
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and
            not utils.mask.getBit(player:getCharVar('CleanSignPost'), 2)
        then
            player:startEvent(8, 1)
        else
            player:startEvent(3)
        end
    elseif xPos > 295.4 and xPos < 307.3 and zPos > 412.8 and zPos < 424.8 then
        if
            player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and
            not utils.mask.getBit(player:getCharVar('CleanSignPost'), 3)
        then
            player:startEvent(9, 1)
        else
            player:startEvent(4)
        end
    else
        print('Unknown Signpost')
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 6 and option == 1 then
        player:setCharVar('CleanSignPost', utils.mask.setBit(player:getCharVar('CleanSignPost'), 0, true))
    elseif csid == 7 and option == 1 then
        player:setCharVar('CleanSignPost', utils.mask.setBit(player:getCharVar('CleanSignPost'), 1, true))
    elseif csid == 8 and option == 1 then
        player:setCharVar('CleanSignPost', utils.mask.setBit(player:getCharVar('CleanSignPost'), 2, true))
    elseif csid == 9 and option == 1 then
        player:setCharVar('CleanSignPost', utils.mask.setBit(player:getCharVar('CleanSignPost'), 3, true))
    end
end

return entity
