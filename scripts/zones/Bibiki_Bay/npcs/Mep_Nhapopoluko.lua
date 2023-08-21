-----------------------------------
-- Area: Bibiki Bay
--  NPC: Mep Nhapopoluko
-- Type: Guild Merchant NPC (Fishing Guild)
-- !pos 464.350 -6 752.731 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:sendGuild(519, 1, 18, 5) then
        player:showText(npc, ID.text.MEP_NHAPOPOLUKO_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
