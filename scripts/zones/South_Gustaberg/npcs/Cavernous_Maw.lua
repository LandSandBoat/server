-----------------------------------
-- Area: South Gustaberg
--  NPC: Cavernous Maw
-- !pos 340 -0.5 -680
-- Teleports Players to Abyssea - Altepa
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/abyssea")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30 then
        if
            player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) == QUEST_ACCEPTED and
            player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_BEAKED_BLUSTERER) == QUEST_AVAILABLE and
            xi.abyssea.getHeldTraverserStones(player) >= 1
        then
            player:startEvent(0)
        else
            player:startEvent(914, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 0 then
        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_BEAKED_BLUSTERER)
    elseif csid == 1 then
        -- Killed Bennu
    elseif csid == 914 and option == 1 then
        player:setPos(432, 0, 321, 125, 218)
    end
end

return entity
