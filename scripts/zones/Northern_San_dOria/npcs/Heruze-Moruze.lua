-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Heruze-Moruze
-- Involved in Mission: 2-3 Windurst
-- !pos -56 -3 36 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(532, 1) and trade:getItemCount() == 1) then -- Trade Magicmart_flyer
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end

end

function onTrigger(player, npc)

    pNation = player:getNation()
    currentMission = player:getCurrentMission(pNation)

    if (pNation == tpz.nation.WINDURST) then
        if (currentMission == tpz.mission.id.windurst.THE_THREE_KINGDOMS and player:getCharVar("MissionStatus") == 1) then
            player:startEvent(582)
        else
            player:startEvent(554)
        end
    elseif (pNation == tpz.nation.BASTOK) then
        player:startEvent(578)
    elseif (pNation == tpz.nation.SANDORIA) then
        player:startEvent(577)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 582) then
        player:setCharVar("MissionStatus", 2)
    end

end
