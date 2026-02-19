-----------------------------------
-- Area: Windurst Woods
--  NPC: Kuzah Hpirohpon
-- Guild Merchant NPC: Clothcrafting Guild
-- !pos -80.068 -3.25 -127.686 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:sendGuild(5152, 6, 21, 0) then
        player:showText(npc, ID.text.KUZAH_HPIROHPON_DIALOG)
    end
end

return entity
