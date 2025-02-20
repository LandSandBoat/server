-----------------------------------
-- Area: Upper Jeuno
--  NPC: Deadly Minnow
-- Involved in Quest: Borghertz's Hands (1st quest only)
-- !pos -5 1 48 244
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('BorghertzHandsFirstTime') == 1 then
        player:startEvent(24)
    else
        local stock =
        {
            12442, 13179,    -- Studded Bandana
            12425, 22800,    -- Silver Mask
            12426, 47025,    -- Banded Helm
            12570, 20976,    -- Studded Vest
            12553, 35200,    -- Silver Mail
            12554, 66792,    -- Banded Mail
            12698, 11012,    -- Studded Gloves
            12681, 18800,    -- Silver Mittens
            12672, 23846,    -- Gauntlets
            12682, 35673,    -- Mufflers
        }

        player:showText(npc, ID.text.DURABLE_SHIELDS_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 then
        player:setCharVar('BorghertzHandsFirstTime', 2)
    end
end

return entity
