-----------------------------------
-- Area: Xarcabard
--  NPC: Cavernous Maw
-- !pos 270 -9 -70
-- Teleports Players to Abyssea - Uleguerand
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/abyssea")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30 then
        local hasStone = xi.abyssea.getHeldTraverserStones(player)
        if
            hasStone >= 1 and
            player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DAWN_OF_DEATH) == QUEST_ACCEPTED and
            player:getQuestStatus(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_MAN_EATING_MITE) == QUEST_AVAILABLE
        then
            player:startEvent(58)
        else
            player:startEvent(204, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 58 then
        player:addQuest(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.A_MAN_EATING_MITE)
    elseif csid == 59 then
        -- Killed Resheph
    elseif csid == 204 and option == 1 then
        player:setPos(-240, -40, -520, 251, 253)
    end
end

return entity
