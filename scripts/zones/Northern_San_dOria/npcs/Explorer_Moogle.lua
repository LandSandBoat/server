-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Explorer Moogle
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/teleports")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

local eventId = 862

function onTrade(player, npc, trade)
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE) == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 532) then
        player:messageSpecial(ID.text.FLYER_REFUSED)
    end
end

function onTrigger(player, npc)
    tpz.teleport.explorerMoogleOnTrigger(player, eventId)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.teleport.explorerMoogleOnEventFinish(player, csid, option, eventId)
end
