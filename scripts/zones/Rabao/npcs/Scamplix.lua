-----------------------------------
-- Area: Rabao
--  NPC: Scamplix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_DISTILLED_WATER,     12 },
        { xi.item.STRIP_OF_MEAT_JERKY,         124 },
        { xi.item.LOAF_OF_GOBLIN_BREAD,        312 },
        { xi.item.CACTUS_ARM,                  832 },
        { xi.item.RABAO_WAYSTONE,            10400 },
        { xi.item.ETHER,                      5025 },
        { xi.item.THUNDERMELON,                338 },
        { xi.item.WATERMELON,                  208 },
        { xi.item.POTION,                      946 },
        { xi.item.ANTIDOTE,                    328 },
        { xi.item.FLASK_OF_BLINDNESS_POTION,  1248 },
        { xi.item.MYTHRIL_EARRING,            4680 },
        { xi.item.WATER_JUG,                   208 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.SCAMPLIX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
