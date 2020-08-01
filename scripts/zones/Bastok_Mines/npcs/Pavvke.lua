-----------------------------------
-- Area: Bastok Mines
--  NPC: Pavvke
-- Starts Quests: Fallen Comrades (100%)
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)

count = trade:getItemCount()
SilverTag = trade:hasItemQty(13116, 1)
Fallen = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FALLEN_COMRADES)

    if (Fallen == 1 and SilverTag == true and count == 1) then
        player:tradeComplete()
        player:startEvent(91)
    elseif (Fallen == 2 and SilverTag == true and count == 1) then
        player:tradeComplete()
        player:startEvent(92)
    end

end

function onTrigger(player, npc)

Fallen = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FALLEN_COMRADES)
pLevel = player:getMainLvl(player)
pFame = player:getFameLevel(BASTOK)

    if (Fallen == 0    and pLevel >= 12 and pFame >= 2) then
        player:startEvent(90)
    else
        player:startEvent(75)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 90) then
        player:addQuest(BASTOK, tpz.quest.id.bastok.FALLEN_COMRADES)
    elseif (csid == 91) then
        player:completeQuest(BASTOK, tpz.quest.id.bastok.FALLEN_COMRADES)
        player:addFame(BASTOK, 120)
        player:addGil(GIL_RATE*550)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*550)
    elseif (csid == 92) then
        player:addFame(BASTOK, 8)
        player:addGil(GIL_RATE*550)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*550)
    end

end
