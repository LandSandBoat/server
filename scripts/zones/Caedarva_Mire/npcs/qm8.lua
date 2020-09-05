-----------------------------------
-- Area: Caedarva Mire
-- NPC:  qm8
-- Gives Lamian Fang Key
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("[TIMER]Lamian_Fang_Key") ~= VanadielDayOfTheYear() then
        if npcUtil.giveItem(player, 2219) then
            player:setCharVar("[TIMER]Lamian_Fang_Key", VanadielDayOfTheYear()) -- Can obtain key once per vanadiel day
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
