-----------------------------------
-- Area: Windurst Waters
--  NPC: Upih Khachla
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.UPIHKHACHLA_SHOP_DIALOG)

    local stock =
    {
        17313, 1107, 1, -- Grenade
        4112,   837, 1, -- Potion
        951,    108, 1, -- Wijnruit
        636,    119, 2, -- Chamomile
        4151,   736, 2, -- Echo Drops
        4128,  4445, 2, -- Ether
        4148,   290, 3, -- Antidote
        1892,  3960, 3, -- Desalinator
        622,     44, 3, -- Dried Marjoram
        4150,  2387, 3, -- Eye Drops
        605,    180, 3, -- Pickaxe
        1893,  3960, 3, -- Salinator
        1020,   276, 3, -- Sickle
        1241,   354, 3, -- Twinkle Powder
    }

    local rank = GetNationRank(xi.nation.WINDURST)
    if rank ~= 1 then
        table.insert(stock, 1022) --Thief's Tools
        table.insert(stock, 3643)
        table.insert(stock, 3)
    end

    if rank == 3 then
        table.insert(stock, 1023) --Living Key
        table.insert(stock, 5520)
        table.insert(stock, 3)
    end

    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
