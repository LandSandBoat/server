-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Bartabaq
-- Type: Outpost Vendor
-- !pos -260 8 -49 11
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.conquest.vendorOnTrigger(player, xi.region.MOVALPOLOS, 32756)
end

-- TODO: Implement evoliths trading.
-- TODO: Check if you can trade equipment.

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        local stock =
        {
            { xi.item.BOTTLE_OF_MOVALPOLOS_WATER, 800 },
            { xi.item.GOBLIN_DOLL,                500 },
            { xi.item.COPPER_NUGGET,              105 },
            { xi.item.CORAL_FUNGUS,               755 },
            { xi.item.CHUNK_OF_KOPPARNICKEL_ORE,  800 },
        }

        xi.shop.general(player, stock)
    end
end

return entity
