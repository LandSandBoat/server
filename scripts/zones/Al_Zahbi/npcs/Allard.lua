-----------------------------------
-- Area: Al Zahbi
--  NPC: Allard
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        12466, 20000,    --Red Cap
        12594, 32500,    --Gambison
        12722, 16900,    --Bracers
        12850, 24500,    --Hose
        12978, 16000    --Socks
    }

    player:showText(npc, ID.text.ALLARD_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
