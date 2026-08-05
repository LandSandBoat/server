-----------------------------------
-- Area: Kazham
--  NPC: Nuh Celodehki
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FISH_MITHKABOB, 1080 },
        { xi.item.BLACKENED_FROG, 3406 },
        { xi.item.ROAST_MUSHROOM,  344 },
        { xi.item.EEL_KABOB,      3000 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.NUHCELODENKI_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
