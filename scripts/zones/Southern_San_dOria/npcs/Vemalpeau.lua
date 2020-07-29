-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Vemalpeau
-- Involved in Quests: Under Oath
-------------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Southern_San_dOria/IDs")

function onTrade(player, npc, trade)
    -- "Flyers for Regine" conditional script

    if (FlyerForRegine == 1) then
        local count = trade:getItemCount()
        local MagicFlyer = trade:hasItemQty(532, 1)
        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

function onTrigger(player, npc)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.UNDER_OATH) == QUEST_ACCEPTED and player:getCharVar("UnderOathCS") == 0) then   -- Quest: Under Oath - PLD AF3
        player:startEvent(7) --Under Oath - mentions the boy missing
    elseif (player:getCharVar("UnderOathCS") == 3 and player:hasKeyItem(tpz.ki.MIQUES_PAINTBRUSH)) then
        player:startEvent(5) --Under Oath - upset about the paintbrush
    elseif (player:getCharVar("UnderOathCS") == 4 and player:hasKeyItem(tpz.ki.STRANGE_SHEET_OF_PAPER)) then
        player:startEvent(3) -- Under Oath - mentions commanding officer
    elseif (player:getCharVar("UnderOathCS") == 9 and player:hasKeyItem(tpz.ki.KNIGHTS_CONFESSION)) then
        player:startEvent(2) -- Under Oath - Thanks you and concludes quest
    else
        player:startEvent(1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 7) then
        player:setCharVar("UnderOathCS", 1)
    elseif (csid == 5) then
        player:setCharVar("UnderOathCS", 4)
        player:delKeyItem(tpz.ki.MIQUES_PAINTBRUSH)
    elseif (csid == 2) then
        player:setCharVar("UnderOathCS", 0)
        player:delKeyItem(tpz.ki.KNIGHTS_CONFESSION)
    end

end
