-----------------------------------
-- Area: La Theine Plateau
--  NPC: Cavernous Maw
-- !pos -557.9 0.001 637.846 102
-- Teleports Players to Abyssea - La Theine
-----------------------------------
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30 then
        local hasStone = xi.abyssea.getHeldTraverserStones(player)
        if
            hasStone >= 1 and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) == xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS) == xi.questStatus.QUEST_AVAILABLE
        then
            player:startEvent(9)
        else
            player:startEvent(218, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 9 then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)
    elseif csid == 10 then
        -- Killed Briareus
    elseif csid == 218 and option == 1 then
        player:setPos(-480, 0, 794, 62, 132)
    end
end

return entity
