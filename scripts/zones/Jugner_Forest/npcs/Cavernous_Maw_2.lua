-----------------------------------
-- Area: Jugner Forest
--  NPC: Cavernous Maw
-- !pos 246.318 -0.709 5.706 104
-- Teleports Players to Abyssea - Vunkerl
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30 then
        if
            xi.abyssea.getHeldTraverserStones(player) >= 1 and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) == xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_BEAST_OF_BASTORE) == xi.questStatus.QUEST_AVAILABLE
        then
            player:startEvent(48)
        else
            player:startEvent(47, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 48 then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_BEAST_OF_BASTORE)
    elseif csid == 49 then
        -- Killed Sedna
    elseif csid == 47 and option == 1 then
        player:setPos(-351, -46.750, 699.5, 10, 217)
    end
end

return entity
