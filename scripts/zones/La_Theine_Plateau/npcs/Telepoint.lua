-----------------------------------
-- Area: La Theine Plateau
--  NPC: Telepoint
-- !pos 420.000 19.104 20.000 102
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    -- trade any normal crystal for a faded crystal
    local item = trade:getItemId()
    if trade:getItemCount() == 1 and item >= 4096 and item <= 4103 and npcUtil.giveItem(player, 613) then
        player:tradeComplete()
    end
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.HOLLA_GATE_CRYSTAL) then
        npcUtil.giveKeyItem(player, tpz.ki.HOLLA_GATE_CRYSTAL)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
