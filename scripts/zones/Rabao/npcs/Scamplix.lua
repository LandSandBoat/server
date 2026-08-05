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
        { xi.item.STRIP_OF_MEAT_JERKY,         120 },
        { xi.item.LOAF_OF_GOBLIN_BREAD,        300 },
        { xi.item.CACTUS_ARM,                  800 },
        { xi.item.RABAO_WAYSTONE,            10000 },
        { xi.item.ETHER,                      4832 },
        { xi.item.THUNDERMELON,                325 },
        { xi.item.WATERMELON,                  200 },
        { xi.item.POTION,                      910 },
        { xi.item.ANTIDOTE,                    316 },
        { xi.item.FLASK_OF_BLINDNESS_POTION,  1200 },
        { xi.item.MYTHRIL_EARRING,            4500 },
        { xi.item.WATER_JUG,                   200 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.SCAMPLIX_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
