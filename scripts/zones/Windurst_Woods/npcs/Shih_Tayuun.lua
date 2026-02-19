-----------------------------------
-- Area: Windurst Woods
--  NPC: Shih Tayuun
-- Guild Merchant NPC: Bonecrafting Guild
-- !pos -3.064 -6.25 -131.374 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(514, 8, 23, 3) then
        player:showText(npc, ID.text.SHIH_TAYUUN_DIALOG)
    end
end

return entity
