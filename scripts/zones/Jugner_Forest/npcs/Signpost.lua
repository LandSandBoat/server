-----------------------------------
-- Area: Jugner Forest
--  NPC: Signpost
-- Involved in Quest: Grimy Signposts
-------------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()

    if X > -79.3 and X < -67.3 and Z > 94.5 and Z < 106.5 then
        if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and not player:getMaskBit(player:getCharVar("CleanSignPost"), 0) then
            player:startEvent(6, 1)
        else
            player:startEvent(1)
        end
    elseif X > -266.2 and X < -254.2 and Z > -29.2 and Z < -17.2 then
        if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and not player:getMaskBit(player:getCharVar("CleanSignPost"), 1) then
            player:startEvent(7, 1)
        else
            player:startEvent(2)
        end
    elseif X > -463.7 and X < -451.7 and Z > -422.1 and Z < -410.1 then
        if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and not player:getMaskBit(player:getCharVar("CleanSignPost"), 2) then
            player:startEvent(8, 1)
        else
            player:startEvent(3)
        end
    elseif X > 295.4 and X < 307.3 and Z > 412.8 and Z < 424.8 then
        if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.GRIMY_SIGNPOSTS) == QUEST_ACCEPTED and not player:getMaskBit(player:getCharVar("CleanSignPost"), 3) then
            player:startEvent(9, 1)
        else
            player:startEvent(4)
        end
    else
        print("Unknown Signpost")
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 6 and option == 1 then
        player:setCharVar("CleanSignPost", utils.mask.setBit(player:getCharVar("CleanSignPost"), 0, true))
    elseif csid == 7 and option == 1 then
        player:setCharVar("CleanSignPost", utils.mask.setBit(player:getCharVar("CleanSignPost"), 1, true))
    elseif csid == 8 and option == 1 then
        player:setCharVar("CleanSignPost", utils.mask.setBit(player:getCharVar("CleanSignPost"), 2, true))
    elseif csid == 9 and option == 1 then
        player:setCharVar("CleanSignPost", utils.mask.setBit(player:getCharVar("CleanSignPost"), 3, true))
    end
end
