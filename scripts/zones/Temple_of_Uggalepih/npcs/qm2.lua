-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Offering ITEM)
-- !pos 388 0 269 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.item.OFFERING_TO_UGGALEPIH) then
        if npcUtil.giveItem(player, xi.item.OFFERING_TO_UGGALEPIH) then -- Uggalepih Offering
            npc:setStatus(xi.status.DISAPPEAR)
            npc:updateNPCHideTime(math.random(900, 7200)) -- 15 minutes to 2 hours
            -- TODO: ??? reappears at new position
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
