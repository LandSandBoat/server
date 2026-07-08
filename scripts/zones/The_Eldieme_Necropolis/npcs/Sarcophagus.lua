-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Sarcophagus
-- Involved in Quests: The Requiem (BARD AF2), A New Dawn (BST AF3)
-- !pos -420 8 500 195
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local offset = npc:getID() - ID.npc.SARCOPHAGUS_OFFSET

    -- THE REQUIEM (holy water)
    if
        player:getCharVar('TheRequiemCS') == 3 and
        player:getCharVar('TheRequiemYumKilled') == 0 and
        npcUtil.tradeHas(trade, xi.item.FLASK_OF_HOLY_WATER) and
        offset == player:getCharVar('TheRequiemRandom') - 1 and
        npcUtil.popFromQM(player, npc, { ID.mob.YUM_KIMIL, ID.mob.YUM_KIMIL + 1, ID.mob.YUM_KIMIL + 2 }, { hide = 0 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        player:setCharVar('TheRequiemAlreadyPoped', 1)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENED)
    end
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.SARCOPHAGUS_OFFSET

    -- A NEW DAWN (Beastmaster AF3)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN) == xi.questStatus.QUEST_ACCEPTED and
        npc:getID() == ID.npc.SARCOPHAGUS_OFFSET
    then
        local aNewDawnEvent = player:getCharVar('ANewDawn_Event')

        if aNewDawnEvent == 4 then
            npcUtil.popFromQM(player, npc, { ID.mob.STURM, ID.mob.TAIFUN, ID.mob.TROMBE }, { claim = false, hide = 0 })
        elseif aNewDawnEvent == 5 then
            player:startEvent(45)
        end

    -- THE REQUIEM (Bard AF2)
    elseif offset == player:getCharVar('TheRequiemRandom') - 1 then
        if player:getCharVar('TheRequiemYumKilled') == 1 then
            player:startEvent(46)
        elseif
            player:getCharVar('TheRequiemAlreadyPoped') == 1 and
            npcUtil.popFromQM(player, npc, { ID.mob.YUM_KIMIL, ID.mob.YUM_KIMIL + 1, ID.mob.YUM_KIMIL + 2 }, { hide = 0 })
        then
            player:messageSpecial(ID.text.SENSE_OF_FOREBODING)
        else
            player:messageSpecial(ID.text.SARCOPHAGUS_CANNOT_BE_OPENED)
        end

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.SARCOPHAGUS_CANNOT_BE_OPENED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- THE REQUIEM
    if csid == 46 then
        player:setCharVar('TheRequiemCS', 0)
        player:setCharVar('TheRequiemYumKilled', 0)
        player:setCharVar('TheRequiemRandom', 0)
        player:setCharVar('TheRequiemAlreadyPoped', 0)
        npcUtil.giveKeyItem(player, xi.ki.STAR_RING1)

    -- A NEW DAWN
    elseif
        csid == 45 and
        npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN, { item = 14222, title = xi.title.PARAGON_OF_BEASTMASTER_EXCELLENCE })
    then
        player:setCharVar('ANewDawn_Event', 6)
        player:delKeyItem(xi.ki.TAMERS_WHISTLE)
    end
end

return entity
