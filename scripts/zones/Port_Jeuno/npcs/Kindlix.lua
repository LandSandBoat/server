-----------------------------------
-- Area: Port Jeuno
--  NPC: Kindlix
-- !pos -18.820 4.000 23.302 246
-----------------------------------
---@type TNpcEntity
local entity = {}

local stock =
{
    { xi.item.CRACKLER,        22 },
    { xi.item.CRACKER,         25 },
    { xi.item.TWINKLE_SHOWER,  25 },
    { xi.item.LITTLE_COMET,    25 },
    { xi.item.SPARKLING_HAND,  25 },
    { xi.item.POPSTAR,         50 },
    { xi.item.BRILLIANT_SNOW,  50 },
    { xi.item.POPPER,          50 },
    { xi.item.POPPER_II,       50 },
    { xi.item.AIRBORNE,       100 },
    { xi.item.AIR_RIDER,      100 },
    { xi.item.BUBBLE_BREEZE,  150 },
    { xi.item.FALLING_STAR,   200 },
    { xi.item.MARINE_BLISS,   250 },
    { xi.item.FLARELET,       250 },
    { xi.item.PAPILLION,      300 },
    { xi.item.ANGELWING,      300 },
    { xi.item.MOG_MISSILE,    300 },
}

entity.onTrigger = function(player, npc)
    if  player:getCharVar('spokeKindlix') == 1 then
        player:startEvent(348)
    else
        player:showText(npc, zones[xi.zone.PORT_JEUNO].text.KINDLIX_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 348 and option == 0 then
        xi.shop.general(player, stock)
        player:setCharVar('spokeKindlix', 0)
    end
end

return entity
