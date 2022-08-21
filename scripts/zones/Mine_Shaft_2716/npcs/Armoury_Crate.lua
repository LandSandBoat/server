-----------------------------------
-- Area: Mine Shaft #2716
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local entity = {}

local loot =
{
    -- ENM: Bionic Bug
    [738] =
    {
        {
            {itemid =    0, droprate = 900}, -- Nothing
            {itemid = 1842, droprate = 100}, -- Cloud Evoker
        },
        {
            {itemid = 1767, droprate = 333}, -- Eltoro Leather
            {itemid = 1762, droprate = 333}, -- Cassia Lumber
            {itemid = 1771, droprate = 334}, -- Dragon Bone
        },
        {
            {itemid =     0, droprate = 625}, -- nothing
            {itemid = 18009, droprate =  75}, -- Martial Knife
            {itemid = 18056, droprate =  75}, -- Martial Scythe
            {itemid = 13695, droprate =  75}, -- Commander's Cape
            {itemid = 15195, droprate = 100}, -- Faerie Hairpin
            {itemid =  4748, droprate =  50}, -- Raise III
        },
        {
            {itemid =     0, droprate = 625}, -- nothing
            {itemid = 18009, droprate =  75}, -- Martial Knife
            {itemid = 18056, droprate =  75}, -- Martial Scythe
            {itemid = 13695, droprate =  75}, -- Commander's Cape
            {itemid = 15195, droprate = 100}, -- Faerie Hairpin
            {itemid =  4748, droprate =  50}, -- Raise III
        },
    },

    -- Automaton Assault Hume
    [xi.race.HUME_M] =
    {
        {
            {itemid = 0,    droprate = 800}, -- Nothing
            {itemid = 1830, droprate = 200}, -- Lugworm Sand
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14793, droprate = 100}, -- Belinky's Earring
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14794, droprate = 100}, -- Quantz's Earring
        },
    },

    -- Automaton Assault Elvaan
    [xi.race.ELVAAN_M] =
    {
        {
            {itemid = 0,    droprate = 800}, -- Nothing
            {itemid = 1830, droprate = 200}, -- Lugworm Sand
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14795, droprate = 100}, -- Desamilion's Earring
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14796, droprate = 100}, -- Melnina's Earring
        },
    },

    -- Automaton Assault Taru
    [xi.race.TARU_M] =
    {
        {
            {itemid = 0,    droprate = 800}, -- Nothing
            {itemid = 1830, droprate = 200}, -- Lugworm Sand
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14797, droprate = 100}, -- Waetoto's Earring
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14798, droprate = 100}, -- Morukaka's Earring
        },
    },

    -- Automaton Assault Mithra
    [xi.race.MITHRA] =
    {
        {
            {itemid = 0,    droprate = 800}, -- Nothing
            {itemid = 1830, droprate = 200}, -- Lugworm Sand
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14799, droprate = 100}, -- Ryakho's Earring
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14799, droprate = 100}, -- Feyuh's Earring
        },
    },

    -- Automaton Assault Galka
    [xi.race.GALKA] =
    {
        {
            {itemid = 0,    droprate = 800}, -- Nothing
            {itemid = 1830, droprate = 200}, -- Lugworm Sand
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14801, droprate = 100}, -- Zedoma's Earring
        },
        {
            {itemid = 0,     droprate = 900}, -- Nothing
            {itemid = 14802, droprate = 100}, -- Gayanj's Earring
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()

    if battlefield and player:getBattlefieldID() ~= 740 then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    else
        local raceLoot = player:getRace()
        if raceLoot < 7 then
            if raceLoot % 2 == 0 then
                raceLoot = raceLoot - 1
            end
        end
        xi.battlefield.HandleLootRolls(battlefield, loot[raceLoot], nil, npc)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
