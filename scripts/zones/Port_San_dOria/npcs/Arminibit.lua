-----------------------------------
-- Area: Port San d'Oria
--  NPC: Arminibit
-- Standard Info NPC
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- "Flyers for Regine" conditional script
    local FlyerForRegine = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)

    if (FlyerForRegine == 1) then
        local count = trade:getItemCount()
        local MagicFlyer = trade:hasItemQty(532, 1)
        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

function onTrigger(player, npc)

    if (player:getMainLvl() >= 30 and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST) == QUEST_AVAILABLE) then
        player:startEvent(24)
    else
        player:startEvent(587)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 24) then
        player:setCharVar("TheHolyCrest_Event", 1)
    end

end
