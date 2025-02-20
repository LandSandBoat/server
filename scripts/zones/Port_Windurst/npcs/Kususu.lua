-----------------------------------
-- Area: Port Windurst
--  NPC: Kususu
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        4641, 1165, 1,    -- Diaga
        4662, 7025, 1,    -- Stoneskin
        4664,  837, 1,    -- Slow
        4610,  585, 2,    -- Cure II
        4636,  140, 2,    -- Banish
        4646, 1165, 2,    -- Banishga
        4661, 2097, 2,    -- Blink
        4609,   61, 3,    -- Cure
        4615, 1363, 3,    -- Curaga
        4622,  180, 3,    -- Poisona
        4623,  324, 3,    -- Paralyna
        4624,  990, 3,    -- Blindna
        4631,   82, 3,    -- Dia
        4651,  219, 3,    -- Protect
        4656, 1584, 3,    -- Shell
        4663,  360, 3,    -- Aquaveil
    }

    player:showText(npc, ID.text.KUSUSU_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
