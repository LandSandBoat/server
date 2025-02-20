-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Whistle ITEM)
-- !pos -150 0 -71 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.item.UGGALEPIH_WHISTLE) then
        if npcUtil.giveItem(player, xi.item.UGGALEPIH_WHISTLE) then -- Uggalepih Whistle
            npc:setStatus(xi.status.DISAPPEAR)
            npc:updateNPCHideTime(7200) -- 2 hours
            -- TODO: ??? reappears at new position
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
