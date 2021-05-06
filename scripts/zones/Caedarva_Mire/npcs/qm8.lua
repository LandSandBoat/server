-----------------------------------
-- Area: Caedarva Mire
--  NPC: qm8
-- Gives Lamian Fang Key
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("[TIMER]Lamian_Fang_Key") ~= VanadielDayOfTheYear() then
        if npcUtil.giveItem(player, 2219) then
            player:setCharVar("[TIMER]Lamian_Fang_Key", VanadielDayOfTheYear()) -- Can obtain key once per vanadiel day
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
