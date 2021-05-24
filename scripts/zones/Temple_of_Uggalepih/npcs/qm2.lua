-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Offering ITEM)
-- !pos 388 0 269 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.items.OFFERING_TO_UGGALEPIH) then
        if npcUtil.giveItem(player, xi.items.OFFERING_TO_UGGALEPIH) then -- Uggalepih Offering
            npc:setStatus(xi.status.DISAPPEAR)
            npc:updateNPCHideTime(math.random(900, 7200)) -- 15 minutes to 2 hours
            -- TODO: ??? reappears at new position
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
