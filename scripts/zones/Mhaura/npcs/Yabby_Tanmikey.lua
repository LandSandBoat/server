-----------------------------------
-- Area: Mhaura
--  NPC: Yabby Tanmikey
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -36.459 -16.000 76.840 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(528, 8, 23, 4) then
        player:showText(npc, ID.text.GOLDSMITHING_GUILD)
    end
end

return entity
