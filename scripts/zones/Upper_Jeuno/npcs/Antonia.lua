-----------------------------------
-- Area: Upper Jeuno
--  NPC: Antonia
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        -- { xi.item.ARASY_SAINTI,      100100 },
        -- { xi.item.ARASY_KNIFE,       100100 },
        -- { xi.item.ARASY_SWORD,       100100 },
        -- { xi.item.ARASY_CLAYMORE,    100100 },
        -- { xi.item.ARASY_TABAR,       100100 },
        -- { xi.item.ARASY_AXE,         100100 },
        -- { xi.item.ARASY_SCYTHE,      100100 },
        -- { xi.item.ARASY_LANCE,       100100 },
        -- { xi.item.YOSHIKIRI,         100100 },
        -- { xi.item.ASHIJIRO_NO_TACHI, 100100 },
        -- { xi.item.ARASY_ROD,         100100 },
        -- { xi.item.ARASY_STAFF,       100100 },
        -- { xi.item.ARASY_BOW,         100100 },
        -- { xi.item.ARASY_GUN,         100100 },
        -- { xi.item.ANIMATOR_Z,        100100 },
        -- { xi.item.ARASY_SACHET,      100100 },
        { xi.item.IRON_ARROW,        7 },
        { xi.item.MYTHRIL_ROD,    6256 },
        { xi.item.WARHAMMER,      6033 },
        { xi.item.OAK_CUDGEL,    11232 },
        { xi.item.MYTHRIL_MACE,  18048 },
        { xi.item.OAK_POLE,      37440 },
        { xi.item.HALBERD,       44550 },
        { xi.item.SCYTHE,        10596 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.VIETTES_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
