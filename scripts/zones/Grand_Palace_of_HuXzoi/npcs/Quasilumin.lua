-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local this = {}

this.onTrade = function(player, npc, trade)
end

this.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.MAP_OF_HUXZOI) then
        local progress = player:getVar("huxzoi_map_progress")
        if progress == 1023 then
            player:showText(npc, ID.text.HUXZOI_MAP_COMPLETE, player:getRace())
            npcUtil.giveKeyItem(player, xi.ki.MAP_OF_HUXZOI)
            return
        else
            index = npc:getID() - ID.npc.QUASILUMIN_OFFSET
            if bit.band(progress, bit.lshift(1, index)) ~= 1 then
                player:setVar("huxzoi_map_progress", bit.bor(progress, bit.lshift(1, index)))
            end
        end
    end
    player:showText(npc, ID.quasilumin_text[npc:getID()])
end

this.onEventUpdate = function(player, csid, option)
end

this.onEventFinish = function(player, csid, option)
end

return this
