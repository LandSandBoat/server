-----------------------------------
-- Area: Bearclaw Pinnacle
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------

local loot =
{
    -- ENM: Follow the White Rabbit
    [641] =
    {
        {
            {itemid =     0, droprate =   50}, -- nothing
            {itemid =  1769, droprate =  450}, -- Square of Galateia
            {itemid =  1764, droprate =   50}, -- Kejusu Satin
            {itemid =  1763, droprate =  450}, -- Viridian Urushi
        },
        {
            {itemid =     0, droprate =  950}, -- nothing
            {itemid =  1842, droprate =   50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate =  325}, -- nothing
            {itemid = 18380, droprate =  225}, -- Martial Sword
            {itemid = 17798, droprate =  125}, -- Shamo
            {itemid = 15301, droprate =   50}, -- Venturer's Belt
            {itemid = 14673, droprate =  100}, -- Serene Ring
            {itemid =  4748, droprate =  175}, -- Scroll of Raise III
        },
        {
            {itemid =     0, droprate =  325}, -- nothing
            {itemid = 18380, droprate =  225}, -- Martial Sword
            {itemid = 17798, droprate =  125}, -- Shamo
            {itemid = 15301, droprate =   50}, -- Venturer's Belt
            {itemid = 14673, droprate =  100}, -- Serene Ring
            {itemid =  4748, droprate =  175}, -- Scroll of Raise III
        },
    },

    -- ENM: When Hell Freezes Over
    [642] =
    {
        {
            {itemid =     0, droprate =  100}, -- nothing
            {itemid =  1769, droprate =  500}, -- Square of Galateia
            {itemid =  1764, droprate =  150}, -- Kejusu Satin
            {itemid =  1763, droprate =  250}, -- Viridian Urushi
        },
        {
            {itemid =     0, droprate =  950}, -- nothing
            {itemid =  1842, droprate =   50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid = 18221, droprate =  125}, -- Martial Bhuj
            {itemid = 17210, droprate =  125}, -- Martial Gun
            {itemid = 17593, droprate =  125}, -- Martial Staff
            {itemid = 13628, droprate =  125}, -- Hexerei Cape
            {itemid = 13647, droprate =  125}, -- Settler's Cape
            {itemid =  4748, droprate =  125}, -- Scroll of Raise III
        },
        {
            {itemid =     0, droprate =  250}, -- nothing
            {itemid = 18221, droprate =  125}, -- Martial Bhuj
            {itemid = 17210, droprate =  125}, -- Martial Gun
            {itemid = 17593, droprate =  125}, -- Martial Staff
            {itemid = 13628, droprate =  125}, -- Hexerei Cape
            {itemid = 13647, droprate =  125}, -- Settler's Cape
            {itemid =  4748, droprate =  125}, -- Scroll of Raise III
        },
    },

    -- ENM: Brothers
    [643] =
    {
        {
            {itemid =     0, droprate =   59}, -- nothing
            {itemid =  1767, droprate =  271}, -- Eltoro Leather
            {itemid =  1762, droprate =  340}, -- Cassia Lumber
            {itemid =  1771, droprate =  330}, -- Dragon Bone
        },
        {
            {itemid =     0, droprate =  956}, -- nothing
            {itemid =  1842, droprate =   44}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate =  118}, -- nothing
            {itemid = 15302, droprate =  123}, -- Scouter's Rope
            {itemid = 17277, droprate =  163}, -- Hedgehog Bomb
            {itemid = 17707, droprate =  167}, -- Martial Anelace
            {itemid = 18098, droprate =  148}, -- Martial Lance
            {itemid =  4748, droprate =  281}, -- Scroll of Raise III
        },
        {
            {itemid =     0, droprate =  118}, -- nothing
            {itemid = 15302, droprate =  128}, -- Scouter's Rope
            {itemid = 17277, droprate =  163}, -- Hedgehog Bomb
            {itemid = 17707, droprate =  167}, -- Martial Anelace
            {itemid = 18098, droprate =  153}, -- Martial Lance
            {itemid =  4748, droprate =  271}, -- Scroll of Raise III
        },
    },

    -- ENM: Holy Cow
    [644] =
    {
        {
            {itemid =  1771, droprate =  200}, -- Dragon Bone
            {itemid =  1767, droprate =  400}, -- Eltoro Leather
            {itemid =  1762, droprate =  400}, -- Cassia Lumber
        },
        {
            {itemid =     0, droprate =  950}, -- nothing
            {itemid =  1842, droprate =   50}, -- Cloud Evoker
        },
        {
            {itemid =     0, droprate =  275}, -- nothing
            {itemid = 17209, droprate =  125}, -- Martial Bow
            {itemid = 18356, droprate =  125}, -- Martial Knuckles
            {itemid = 13648, droprate =  175}, -- Gigant Mantle
            {itemid = 13694, droprate =  125}, -- Psilos Mantle
            {itemid =  4748, droprate =  175}, -- Scroll of Raise III
        },
        {
            {itemid =     0, droprate =  275}, -- nothing
            {itemid = 17209, droprate =  125}, -- Martial Bow
            {itemid = 18356, droprate =  125}, -- Martial Knuckles
            {itemid = 13648, droprate =  175}, -- Gigant Mantle
            {itemid = 13694, droprate =  125}, -- Psilos Mantle
            {itemid =  4748, droprate =  175}, -- Scroll of Raise III
        },
    },
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        tpz.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
