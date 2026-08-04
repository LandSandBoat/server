-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Sarcophagus
-- Involved in Quests: A New Dawn (BST AF3)
-- !pos -420 8 500 195
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
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

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.SARCOPHAGUS_CANNOT_BE_OPENED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- A NEW DAWN
    if
        csid == 45 and
        npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN, { item = 14222, title = xi.title.PARAGON_OF_BEASTMASTER_EXCELLENCE })
    then
        player:setCharVar('ANewDawn_Event', 6)
        player:delKeyItem(xi.ki.TAMERS_WHISTLE)
    end
end

return entity
