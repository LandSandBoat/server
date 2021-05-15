-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ratihb
-- Standard Info NPC
-- !pos 75.225 -6.000 -137.203 50
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("EquippedforAllOccasions") == 4 and player:getCharVar("LuckOfTheDraw") == 6 then
        player:startEvent(772)
    elseif player:getCharVar("AgainstAllOdds") == 2 and (player:getCharVar("AgainstAllOddsTimer") < os.time() or player:getCharVar("AgainstAllOddsTimer") == 0) then
        player:startEvent(604) -- reacquire life float, account for chars on quest previously without a var
    else
        player:startEvent(603)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 772 then
        npcUtil.completeQuest(player, AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS, {item = 18702, var = {"EquippedforAllOccasions", "LuckOfTheDraw"}})
    elseif csid == 604 then
        npcUtil.giveKeyItem(player, xi.ki.LIFE_FLOAT)
        player:setCharVar("AgainstTimer", getMidnight())
    end
end

return entity
