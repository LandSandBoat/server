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
        { xi.item.KUNAI,              928 },
        { xi.item.WAKIZASHI,         2520 },
        { xi.item.UCHIGATANA,        5602 },
        { xi.item.KANESADA,         20790 },
        { xi.item.TACHI,             3298 },
        { xi.item.NODACHI,           8530 },
        { xi.item.TANEGASHIMA,      13715 },
        { xi.item.SHURIKEN,            52 },
        { xi.item.HACHIMAKI,          866 },
        { xi.item.COTTON_HACHIMAKI,  5128 },
        { xi.item.SOIL_HACHIMAKI,   14061 },
        { xi.item.KENPOGI,           1307 },
        { xi.item.COTTON_DOGI,       7728 },
        { xi.item.SOIL_GI,          20790 },
        { xi.item.TEKKO,              719 },
        { xi.item.COTTON_TEKKO,      4252 },
        { xi.item.SOIL_TEKKO,       11642 },
        { xi.item.SITABAKI,          1044 },
        { xi.item.COTTON_SITABAKI,   6192 },
        { xi.item.SOIL_SITABAKI,    16934 },
        { xi.item.KYAHAN,             666 },
        { xi.item.COTTON_KYAHAN,     3962 },
        { xi.item.SOIL_KYAHAN,      17350 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AKAMAFULA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
