-----------------------------------
-- Area: Ghelsba_Outpost
--  NPC: Armoury Crate
-- Ghelsba_Outpost Armoury_Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Toadal Recall
    [36] =
    {
        {
            { itemid = xi.item.KING_TRUFFLE, droprate = 1000 }, -- king_truffle
        },

        {
            { itemid = xi.item.JUG_OF_SEEDBED_SOIL, droprate = 1000 }, -- jug_of_seedbed_soil
        },

        {
            { itemid = xi.item.NONE,             droprate = 200 }, -- nothing
            { itemid = xi.item.MAGICIANS_SHIELD, droprate = 200 }, -- magicians_shield
            { itemid = xi.item.MERCENARYS_TARGE, droprate = 200 }, -- mercenarys_targe
            { itemid = xi.item.BEATERS_ASPIS,    droprate = 200 }, -- beaters_aspis
            { itemid = xi.item.PILFERERS_ASPIS,  droprate = 200 }, -- pilferers_aspis
        },

        {
            { itemid = xi.item.NONE,            droprate = 250 }, -- nothing
            { itemid = xi.item.TRIMMERS_MANTLE, droprate = 250 }, -- trimmers_mantle
            { itemid = xi.item.GENIN_MANTLE,    droprate = 250 }, -- genin_mantle
            { itemid = xi.item.WARLOCKS_MANTLE, droprate = 250 }, -- warlocks_mantle
        },

        {
            { itemid = xi.item.NONE,                  droprate = 625 }, -- nothing
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_PHALANX,     droprate = 125 }, -- scroll_of_phalanx
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
        },

        {
            { itemid = xi.item.NONE,            droprate = 250 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 250 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_BODY,  droprate = 250 }, -- mannequin_body
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 250 }, -- mannequin_hands
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
