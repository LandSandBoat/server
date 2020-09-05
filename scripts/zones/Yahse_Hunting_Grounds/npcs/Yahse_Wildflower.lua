-----------------------------------
-- Area: Yahse Hunting Grounds
--  NPC: Yahse Wildflower
-- Involved in quest Children of the Rune
-- pos 370.6285 0.6692 153.3728
-----------------------------------
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Yahse_Hunting_Grounds/IDs")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- CHILDREN OF THE RUNE
    if player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.CHILDREN_OF_THE_RUNE) == QUEST_ACCEPTED then
        npcUtil.giveKeyItem(player, tpz.ki.YAHSE_WILDFLOWER_PETAL)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
