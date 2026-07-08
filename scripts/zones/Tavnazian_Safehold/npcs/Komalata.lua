-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Komalata
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock = {}

    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.SHELTERING_DOUBT then
        stock =
        {
            { xi.item.BOTTLE_OF_APPLE_VINEGAR,   88 },
            { xi.item.LOAF_OF_BLACK_BREAD,      120 },
            { xi.item.STRIP_OF_MEAT_JERKY,      120 },
            { xi.item.CHUNK_OF_ROCK_SALT,        16 },
            { xi.item.BAG_OF_RYE_FLOUR,          40 },
            { xi.item.BAG_OF_SAN_DORIAN_FLOUR,   60 },
            { xi.item.SAN_DORIAN_CARROT,         32 },
            { xi.item.EAR_OF_MILLIONCORN,        48 },
            { xi.item.SPRIG_OF_APPLE_MINT,      316 },
            { xi.item.FLASK_OF_DISTILLED_WATER,  12 },
        }
    else
        stock =
        {
            { xi.item.STRIP_OF_MEAT_JERKY,      120 },
            { xi.item.CHUNK_OF_ROCK_SALT,        16 },
            { xi.item.BAG_OF_RYE_FLOUR,          40 },
            { xi.item.FLASK_OF_DISTILLED_WATER,  12 },
        }
    end

    player:showText(npc, zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.KOMALATA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
