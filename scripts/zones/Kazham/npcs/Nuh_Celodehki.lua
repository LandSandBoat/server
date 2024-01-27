-----------------------------------
-- Area: Kazham
--  NPC: Nuh Celodehki
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4398,  993,    -- Fish Mithkabob
        4536, 3133,    -- Blackened Frog
        4410,  316,    -- Roast Mushroom
        4457, 2700,    -- Eel Kabob
    }

    player:showText(npc, ID.text.NUHCELODENKI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
