-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Rahal
-- Involved in Quests: The Holy Crest, Lure of the Wildcat (San d'Oria)
-- !pos -28 0.1 -6 233
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local crestProgress = player:getCharVar('TheHolyCrest_Event')
    local hasDragonCurseRemedy = player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
    local stalkerQuest = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
    local stalkerProgress = player:getCharVar('KnightStalker_Progress')
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 17)
    then
        player:startEvent(559)
    -- Need to speak with Rahal to get Dragon Curse Remedy
    elseif crestProgress == 5 and not hasDragonCurseRemedy then
        player:startEvent(60) -- Gives key item
    elseif crestProgress == 5 and hasDragonCurseRemedy then
        player:startEvent(122) -- Reminder to go to Gelsba

    -- Completed AF2, AF3 available, and currently on DRG.  No level check, since they cleared AF2.
    elseif
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS) == xi.questStatus.QUEST_COMPLETED and
        stalkerQuest == xi.questStatus.QUEST_AVAILABLE and player:getMainJob() == xi.job.DRG
    then
        if player:getCharVar('KnightStalker_Declined') == 0 then
            player:startEvent(121) -- Start AF3
        else
            player:startEvent(120) -- Short version if they previously declined
        end
    elseif stalkerQuest == xi.questStatus.QUEST_ACCEPTED then
        if stalkerProgress == 0 then
            player:startEvent(119) -- Reminder to go to Brugaire/Ceraulian
        elseif player:hasKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) then
            if stalkerProgress == 1 then
                player:startEvent(78) -- Reaction to challenge, go talk to Balasiel
            elseif stalkerProgress == 2 then
                player:startEvent(69) -- Reminder to talk to Balasiel
            elseif stalkerProgress == 3 then
                player:startEvent(110) -- To the south with you
            end
        end
    elseif player:getCharVar('KnightStalker_Option2') == 1 then
        player:startEvent(118) -- Optional CS after Knight Stalker

    else
        player:startEvent(529)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 60 then
        npcUtil.giveKeyItem(player, xi.ki.DRAGON_CURSE_REMEDY)
    elseif csid == 559 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 17, true))
    elseif csid == 121 then
        if option == 1 then
            player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
        else
            player:setCharVar('KnightStalker_Declined', 1)
        end
    elseif csid == 120 and option == 1 then
        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
        player:setCharVar('KnightStalker_Declined', 0)
    elseif csid == 78 then
        player:setCharVar('KnightStalker_Progress', 2)
    elseif csid == 110 then
        player:setCharVar('KnightStalker_Progress', 4)
    elseif csid == 118 then
        player:setCharVar('KnightStalker_Option2', 0)
    end
end

return entity
