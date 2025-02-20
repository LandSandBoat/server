-----------------------------------
-- Area: North Gustaberg
--  NPC: Cavernous Maw
-- !pos -78 -0.5 600 106
-- Teleports Players to Abyssea - Grauberg
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30 then
        if
            xi.abyssea.getHeldTraverserStones(player) >= 1 and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) == xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE) == xi.questStatus.QUEST_AVAILABLE
        then
            player:startEvent(0)
        else
            player:startEvent(908, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 0 then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE)
    elseif csid == 1 then
        -- Killed Amphitrite
    elseif csid == 908 and option == 1 then
        player:setPos(-555, 31, -760, 0, 254)
    end
end

return entity
