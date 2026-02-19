-----------------------------------
-- Area: Bibiki Bay
--  NPC: Mep Nhapopoluko
-- Type: Guild Merchant NPC (Fishing Guild)
-- !pos 464.350 -6 752.731 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(519, 1, 18, 5) then
        player:showText(npc, ID.text.MEP_NHAPOPOLUKO_DIALOG)
    end
end

return entity
