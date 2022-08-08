-----------------------------------
-- Area: Throne Room
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local entity = {}

local loot =
{
    -- Kindred Spirits
    [162] =
    {
    {
            {itemid = 902, droprate = 1000}, -- Demon Horn
        },
    {
            {itemid = 16726, droprate =  200}, -- forsetis_axe
            {itemid = 17647, droprate =  200}, -- aramiss_rapier
            {itemid = 17491, droprate =  200}, -- spartan_cesti
            {itemid = 17788, droprate =  200}, -- sairen
            {itemid = 17574, droprate =  200}, -- Archalaus's Pole
        },
    {
            {itemid = 18172, droprate = 250}, -- Light Boomerang
            {itemid = 17235, droprate = 250}, -- Armbrust
            {itemid = 18087, droprate = 250}, -- Schwarz Lance
            {itemid = 17822, droprate = 250}, -- Omokage
        },
    {
            {itemid = 16788, droprate = 250}, -- Vassago's Scythe
            {itemid = 16684, droprate = 250}, -- Kabrakan's Axe
            {itemid = 17648, droprate = 250}, -- Dragvandil
            {itemid = 17379, droprate = 250}, -- Hamelin Flute
        },
    {
            {itemid =  803, droprate = 250}, -- Sunstone
            {itemid =  801, droprate = 250}, -- Chrysoberyl
            {itemid = 4224, droprate = 250}, -- Demon Quiver
            {itemid =  653, droprate = 250}, -- Mythril Ingot
        },
    {
            {itemid =     0, droprate = 500}, -- nothing
            {itemid = 5030,  droprate = 250}, -- Scroll of Carnage Elegy
            {itemid = 4897,  droprate = 250}, -- Ice Spirit Pact
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
