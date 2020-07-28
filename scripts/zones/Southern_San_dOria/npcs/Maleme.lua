-----------------------------------
-- Area: Southern San dOria
--  NPC: Maleme
-- Type: Weather Reporter
-- Involved in Quest: Flyers for Regine
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    -- "Flyers for Regine" conditional script
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
        local count = trade:getItemCount()
        local MagicFlyer = trade:hasItemQty(532, 1)

        if (MagicFlyer == true and count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(632, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
