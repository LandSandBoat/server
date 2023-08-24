-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Cavernous Maw
-- !pos -28.597, 46.056, -685.754 117
-- Teleports Players to Abyssea - Tahrongi
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
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
            player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.MEGADRILE_MENACE) == QUEST_AVAILABLE and
            xi.abyssea.getHeldTraverserStones(player) >= 1
        then
            player:startEvent(38)
        else
            player:startEvent(100, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 38 then
        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.MEGADRILE_MENACE)
    elseif csid == 39 then
        -- Killed Glavoid
    elseif csid == 100 and option == 1 then
        player:setPos(-24, 44, -678, 240, 45)
    end
end

return entity
