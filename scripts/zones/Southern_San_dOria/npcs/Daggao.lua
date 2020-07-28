-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Daggao
-- Involved in Quest: Peace for the Spirit, Lure of the Wildcat (San d'Oria)
-- !pos 89 0 119 230
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(532, 1) and trade:getItemCount() == 1) then -- Trade Magicmart_flyer
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end

end

function onTrigger(player, npc)

    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 0) == false) then
        player:startEvent(810)
    elseif (player:getCharVar("peaceForTheSpiritCS") == 3) then
        player:startEvent(72)
    elseif (player:getCharVar("peaceForTheSpiritCS") == 5) then
        player:startEvent(73)
    else
        player:startEvent(60)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 810) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 0, true)
    elseif (csid == 72) then
        player:setCharVar("peaceForTheSpiritCS", 4)
    end

end
