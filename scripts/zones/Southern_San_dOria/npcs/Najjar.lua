-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Najjar
--  General Info NPC
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")

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
    if (player:getCharVar("UnderOathCS") == 1) then  -- Quest: Under Oath - PLD AF3
        player:startEvent(16)
    else
        player:startEvent(17)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 16) then
        player:setCharVar("UnderOathCS", 2)  -- Quest: Under Oath - PLD AF3
    end
end
