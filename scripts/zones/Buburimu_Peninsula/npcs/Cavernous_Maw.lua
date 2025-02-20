-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Cavernous Maw
-- !pos -334 -24 52
-- Teleports Players to Abyssea - Attohwa
-----------------------------------
local ID = zones[xi.zone.BUBURIMU_PENINSULA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30 then
        local hasStone = xi.abyssea.getHeldTraverserStones(player)
        if
            hasStone >= 1 and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) == xi.questStatus.QUEST_ACCEPTED and
            player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_FLUTTERY_FIEND) == xi.questStatus.QUEST_AVAILABLE
        then
            player:startEvent(62)
        else
            player:startEvent(61, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 62 then
        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_FLUTTERY_FIEND)
    elseif csid == 63 then
        -- Killed Itzpapalotl
    elseif csid == 61 and option == 1 then
        player:setPos(-140, 20, -181, 131, 215)
    end
end

return entity
