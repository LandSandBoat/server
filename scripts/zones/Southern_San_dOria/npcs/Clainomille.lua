-----------------------------------
-- Area: Southern San d'Oria
--   NPC: Clainomille
-- Type: Standard NPC
-- !pos -72.771 0.999 -6.112 230
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED then
        if trade:hasItemQty(532, 1) and trade:getItemCount() == 1 then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(613)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
