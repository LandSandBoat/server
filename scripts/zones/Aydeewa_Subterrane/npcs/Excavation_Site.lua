-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: Excavation Site (Olduum Ring quest)
-- !pos 390 1 349 68
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:hasKeyItem(xi.ki.DKHAAYAS_RESEARCH_JOURNAL)) then -- If no journal, just stop right here
        if (trade:hasItemQty(605, 1) and trade:getItemCount() == 1) then -- Trade Pickaxe
            local keyItems =
            {
                xi.ki.ELECTROCELL,
                xi.ki.ELECTROPOT,
                xi.ki.ELECTROLOCOMOTIVE,
            }
            local KI = math.random(1, 3)
            if (player:hasKeyItem(xi.ki.ELECTROCELL) or player:hasKeyItem(xi.ki.ELECTROPOT) or player:hasKeyItem(xi.ki.ELECTROLOCOMOTIVE)) == false then
                player:tradeComplete()
                player:addKeyItem(keyItems[KI])
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItems[KI])
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
