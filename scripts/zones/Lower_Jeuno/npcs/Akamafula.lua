-----------------------------------
-- Area: Lower Jeuno
--  NPC: Akamafula
-- Type: Tenshodo Merchant
-- !pos 28.465 2.899 -46.699 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        return -- Anti-Cheat.
    end

    local stock =
    {
        { xi.item.KUNAI,              884 },
        { xi.item.WAKIZASHI,         2400 },
        { xi.item.UCHIGATANA,        5336 },
        { xi.item.KANESADA,         19800 },
        { xi.item.TACHI,             3141 },
        { xi.item.NODACHI,           8124 },
        { xi.item.TANEGASHIMA,      13062 },
        { xi.item.SHURIKEN,             50 },
        { xi.item.HACHIMAKI,          825 },
        { xi.item.COTTON_HACHIMAKI,  4884 },
        { xi.item.SOIL_HACHIMAKI,   13392 },
        { xi.item.KENPOGI,           1245 },
        { xi.item.COTTON_DOGI,       7360 },
        { xi.item.SOIL_GI,          19800 },
        { xi.item.TEKKO,              685 },
        { xi.item.COTTON_TEKKO,      4050 },
        { xi.item.SOIL_TEKKO,       11088 },
        { xi.item.SITABAKI,           995 },
        { xi.item.COTTON_SITABAKI,   5898 },
        { xi.item.SOIL_SITABAKI,    16128 },
        { xi.item.KYAHAN,             635 },
        { xi.item.COTTON_KYAHAN,     3774 },
        { xi.item.SOIL_KYAHAN,      16524 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AKAMAFULA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
