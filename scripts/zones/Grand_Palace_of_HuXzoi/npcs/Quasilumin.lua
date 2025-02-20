-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  NPC: Quasilumin
-- !pos
-----------------------------------
local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local index = npc:getID() - ID.npc.QUASILUMIN_OFFSET

    if not player:hasKeyItem(xi.ki.MAP_OF_HUXZOI) then
        local progress = player:getCharVar('huxzoi_map_progress')

        if progress == 1023 then
            player:showText(npc, ID.text.HUXZOI_MAP_COMPLETE, player:getRace())
            npcUtil.giveKeyItem(player, xi.ki.MAP_OF_HUXZOI)
            return
        else
            if bit.band(progress, bit.lshift(1, index)) ~= 1 then
                player:setCharVar('huxzoi_map_progress', bit.bor(progress, bit.lshift(1, index)))
            end
        end
    end

    player:showText(npc, ID.text.QUASILUMIN_MAP_QUEST_OFFSET + index)
end

return entity
