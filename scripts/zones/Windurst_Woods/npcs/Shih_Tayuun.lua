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
    if xi.guildShops.onTrigger(player, npc) then
        player:showText(npc, ID.text.SHIH_TAYUUN_DIALOG)
    end
end

return entity
