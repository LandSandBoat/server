-----------------------------------
-- Area: La Theine Plateau
--  NPC: Cavernous Maw
-- !pos -557.9 0.001 637.846 102
-- Teleports Players to Abyssea - La Theine
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/abyssea")
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (ENABLE_ABYSSEA == 1 and player:getMainLvl() >= 30) then
        local HasStone = tpz.abyssea.getTravStonesTotal(player)
        if (HasStone >= 1 and player:getQuestStatus(ABYSSEA, tpz.quest.id.abyssea.DAWN_OF_DEATH) == QUEST_ACCEPTED
        and player:getQuestStatus(ABYSSEA, tpz.quest.id.abyssea.A_GOLDSTRUCK_GIGAS) == QUEST_AVAILABLE) then
            player:startEvent(9)
        else
            player:startEvent(218, 0, 1) -- No param = no entry.
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 9) then
        player:addQuest(ABYSSEA, tpz.quest.id.abyssea.A_GOLDSTRUCK_GIGAS)
    elseif (csid == 10) then
        -- Killed Briareus
    elseif (csid == 218 and option == 1) then
        player:setPos(-480, 0, 794, 62, 132)
    end
end
