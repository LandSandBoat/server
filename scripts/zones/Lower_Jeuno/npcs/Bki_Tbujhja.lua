-----------------------------------
-- Area: Lower Jeuno
--  NPC: Bki Tbujhja
-- Involved in Quest: The Old Monument
-- Starts and Finishes Quests: Path of the Bard (just start), The Requiem (BARD AF2)
-- !pos -22 0 -60 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- THE REQUIEM (holy water)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('TheRequiemCS') == 2 and
        trade:hasItemQty(xi.item.FLASK_OF_HOLY_WATER, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(151)
    end
end

entity.onTrigger = function(player, npc)
    local theRequiem = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM)

    -- PATH OF THE BARD (Bard Flag)
    if
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.A_MINSTREL_IN_DESPAIR) == xi.questStatus.QUEST_COMPLETED and
        player:getCharVar('PathOfTheBard_Event') == 0
    then
        player:startEvent(182) -- mentions song runes in Valkurm

    -- THE REQUIEM (Bard AF2)
    elseif
        player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY) == xi.questStatus.QUEST_COMPLETED and
        theRequiem == xi.questStatus.QUEST_AVAILABLE and
        player:getMainJob() == xi.job.BRD and
        player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL
    then
        if player:getCharVar('TheRequiemCS') == 0 then
            player:startEvent(145) -- Long dialog & Start Quest "The Requiem"
        else
            player:startEvent(148) -- Shot dialog & Start Quest "The Requiem"
        end

    elseif
        theRequiem == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('TheRequiemCS') == 2
    then
        player:startEvent(146) -- During Quest "The Requiem" (before trading Holy Water)

    elseif
        theRequiem == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('TheRequiemCS') == 3 and
        not player:hasKeyItem(xi.ki.STAR_RING1)
    then
        if math.random(1, 100) <= 50 then
            player:startEvent(147) -- oh, did you take the holy water and play the requiem? you must do both!
        else
            player:startEvent(149) -- his stone sarcophagus is deep inside the eldieme necropolis.
        end

    elseif
        theRequiem == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.STAR_RING1)
    then
        player:startEvent(150) -- Finish Quest "The Requiem"

    elseif theRequiem == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(134) -- Standard dialog after "The Requiem"

    -- DEFAULT DIALOG
    else
        player:startEvent(180)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- PATH OF THE BARD
    if csid == 182 then
        player:setCharVar('PathOfTheBard_Event', 1)

    -- THE REQUIEM
    elseif csid == 145 and option == 0 then
        player:setCharVar('TheRequiemCS', 1) -- player declines quest
    elseif
        (csid == 145 or csid == 148) and
        option == 1
    then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM)
        player:setCharVar('TheRequiemCS', 2)

    elseif csid == 151 then
        player:setCharVar('TheRequiemCS', 3)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.FLASK_OF_HOLY_WATER) -- Holy Water (just message)
        player:setCharVar('TheRequiemRandom', math.random(1, 5)) -- pick a random sarcophagus

    elseif csid == 150 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CHORAL_SLIPPERS)
        else
            player:addItem(xi.item.CHORAL_SLIPPERS)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.CHORAL_SLIPPERS)
            player:addFame(xi.fameArea.JEUNO, 30)
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM)
        end
    end
end

return entity
