-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Matildie
-- Adventurer's Assistant
-------------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(631)
        player:addGil(GIL_RATE*50)
        player:tradeComplete()
    end

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
    player:startEvent(587)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 631) then
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end
end
