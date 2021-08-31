-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Tonberry Rattle ITEM)
-- !pos 269 0 91 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.items.TONBERRY_RATTLE) then
        if npcUtil.giveItem(player, xi.items.TONBERRY_RATTLE) then -- Tonberry Rattle
            npc:setStatus(xi.status.DISAPPEAR)
            npc:updateNPCHideTime(7200) -- 2 hours
            -- TODO: ??? reappears at new position
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
