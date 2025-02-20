-----------------------------------
-- Area: Port Jeuno
--  NPC: Pyropox
-- !pos -17.580 4.000 24.600 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

local stock =
{
    4251,   25,    -- Festive Fan
    4252,   25,    -- Summer Fan
    4256,   25,    -- Ouka Ranman
    4184,   50,    -- Kongou Inaho
    4185,   50,    -- Meifu Goma
    4253,   50,    -- Spirit Masque
    5881,   50,    -- Shisai Kaboku
    4183,  100,    -- Konron Hassen
    5360,  100,    -- Muteppo
    5361,  100,    -- Datechochin
    6268,  150,    -- Komanezumi
    5884,  250,    -- Rengedama
    5532,  250,    -- Ichinintousen Koma
    5725,  300,    -- Goshikitenge
}

entity.onTrigger = function(player, npc)
    if player:getCharVar('spokePyropox') == 1 then
        player:startEvent(349)
    else
        player:showText(npc, ID.text.PYROPOX_SHOP_DIALOG)
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
