-----------------------------------
-- Area: Upper Jeuno
--  NPC: Deadly Minnow
-- Involved in Quest: Borghertz's Hands (1st quest only)
-- !pos -5 1 48 244
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('BorghertzHandsFirstTime') == 1 then
        player:startEvent(24)
    else
        local stock =
        {
            { xi.item.STUDDED_BANDANA, 14326 },
            { xi.item.SILVER_MASK,     22800 },
            { xi.item.BANDED_HELM,     47025 },
            { xi.item.STUDDED_VEST,    22800 },
            { xi.item.SILVER_MAIL,     35200 },
            { xi.item.BANDED_MAIL,     72600 },
            { xi.item.STUDDED_GLOVES,  11970 },
            { xi.item.SILVER_MITTENS,  18800 },
            { xi.item.GAUNTLETS,       25920 },
            { xi.item.MUFFLERS,        38775 },
        }

        player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.DURABLE_SHIELDS_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 then
        player:setCharVar('BorghertzHandsFirstTime', 2)
    end
end

return entity
