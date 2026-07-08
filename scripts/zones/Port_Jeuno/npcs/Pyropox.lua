-----------------------------------
-- Area: Port Jeuno
--  NPC: Pyropox
-- !pos -17.580 4.000 24.600 246
-----------------------------------
---@type TNpcEntity
local entity = {}

local stock =
{
    { xi.item.FESTIVE_FAN,         25 },
    { xi.item.SUMMER_FAN,          25 },
    { xi.item.OUKA_RANMAN,         25 },
    { xi.item.KONGOU_INAHO,        50 },
    { xi.item.MEIFU_GOMA,          50 },
    { xi.item.SPIRIT_MASQUE,       50 },
    { xi.item.SHISAI_KABOKU,       50 },
    { xi.item.KONRON_HASSEN,      100 },
    { xi.item.MUTEPPO,            100 },
    { xi.item.DATECHOCHIN,        100 },
    { xi.item.KOMANEZUMI,         150 },
    { xi.item.RENGEDAMA,          250 },
    { xi.item.ICHININTOUSEN_KOMA, 250 },
    { xi.item.GOSHIKITENGE,       300 },
}

entity.onTrigger = function(player, npc)
    if player:getCharVar('spokePyropox') == 1 then
        player:startEvent(349)
    else
        player:showText(npc, zones[xi.zone.PORT_JEUNO].text.PYROPOX_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 349 and option == 0 then
        xi.shop.general(player, stock)
        player:setCharVar('spokePyropox', 0)
    end
end

return entity
