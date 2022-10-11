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
            { itemid =    0, droprate = 900 }, -- Nothing
            { itemid = 1842, droprate = 100 }, -- Cloud Evoker
        },
        {
            { itemid = 1767, droprate = 333 }, -- Eltoro Leather
            { itemid = 1762, droprate = 333 }, -- Cassia Lumber
            { itemid = 1771, droprate = 334 }, -- Dragon Bone
        },
        {
            { itemid =     0, droprate = 625 }, -- nothing
            { itemid = 18009, droprate =  75 }, -- Martial Knife
            { itemid = 18056, droprate =  75 }, -- Martial Scythe
            { itemid = 13695, droprate =  75 }, -- Commander's Cape
            { itemid = 15195, droprate = 100 }, -- Faerie Hairpin
            { itemid =  4748, droprate =  50 }, -- Raise III
        },
        {
            { itemid =     0, droprate = 625 }, -- nothing
            { itemid = 18009, droprate =  75 }, -- Martial Knife
            { itemid = 18056, droprate =  75 }, -- Martial Scythe
            { itemid = 13695, droprate =  75 }, -- Commander's Cape
            { itemid = 15195, droprate = 100 }, -- Faerie Hairpin
            { itemid =  4748, droprate =  50 }, -- Raise III
        },
    },

    -- Automaton Assault Hume
    [xi.race.HUME_M] =
    {
        {
            { itemid = 0,    droprate = 800 }, -- Nothing
            { itemid = 1830, droprate = 200 }, -- Lugworm Sand
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14793, droprate = 100 }, -- Belinky's Earring
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14794, droprate = 100 }, -- Quantz's Earring
        },
    },

    -- Automaton Assault Elvaan
    [xi.race.ELVAAN_M] =
    {
        {
            { itemid = 0,    droprate = 800 }, -- Nothing
            { itemid = 1830, droprate = 200 }, -- Lugworm Sand
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14795, droprate = 100 }, -- Desamilion's Earring
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14796, droprate = 100 }, -- Melnina's Earring
        },
    },

    -- Automaton Assault Taru
    [xi.race.TARU_M] =
    {
        {
            { itemid = 0,    droprate = 800 }, -- Nothing
            { itemid = 1830, droprate = 200 }, -- Lugworm Sand
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14797, droprate = 100 }, -- Waetoto's Earring
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14798, droprate = 100 }, -- Morukaka's Earring
        },
    },

    -- Automaton Assault Mithra
    [xi.race.MITHRA] =
    {
        {
            { itemid = 0,    droprate = 800 }, -- Nothing
            { itemid = 1830, droprate = 200 }, -- Lugworm Sand
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14799, droprate = 100 }, -- Ryakho's Earring
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14799, droprate = 100 }, -- Feyuh's Earring
        },
    },

    -- Automaton Assault Galka
    [xi.race.GALKA] =
    {
        {
            { itemid = 0,    droprate = 800 }, -- Nothing
            { itemid = 1830, droprate = 200 }, -- Lugworm Sand
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14801, droprate = 100 }, -- Zedoma's Earring
        },
        {
            { itemid = 0,     droprate = 900 }, -- Nothing
            { itemid = 14802, droprate = 100 }, -- Gayanj's Earring
        },
    },

    -- Pulling the Strings Specific Job Rewards
    [xi.job.WAR] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.JANIZARY_EARRING, droprate = 250 },
        },
    },
    [xi.job.MNK] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.COUNTER_EARRING, droprate = 250 },
        },
    },

    [xi.job.WHM] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.HEALING_FEATHER, droprate = 250 },
        },
    },

    [xi.job.BLM] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.SPIRIT_LANTERN, droprate = 250 },
        },
    },

    [xi.job.RDM] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.SANATION_RING, droprate = 250 },
        },
    },

    [xi.job.THF] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.ASSASSINS_RING, droprate = 250 },
        },
    },

    [xi.job.PLD] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.VIAL_OF_REFRESH_MUSK, droprate = 250 },
        },
    },

    [xi.job.DRK] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.TACTICAL_RING, droprate = 250 },
        },
    },

    [xi.job.BST] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.PACIFIST_RING, droprate = 250 },
        },
    },

    [xi.job.BRD] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.GETSUL_RING, droprate = 250 },
        },
    },

    [xi.job.RNG] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.DEADEYE_EARRING, droprate = 250 },
        },
    },

    [xi.job.SAM] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.GAMUSHARA_EARRING, droprate = 250 },
        },
    },

    [xi.job.NIN] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.NARUKO_EARRING, droprate = 250 },
        },
    },

    [xi.job.DRG] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.BAG_OF_WYVERN_FEED, droprate = 250 },
        },
    },

    [xi.job.SMN] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.ASTRAL_POT, droprate = 250 },
        },
    },

    [xi.job.BLU] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.DEATH_CHAKRAM, droprate = 250 },
        },
    },

    [xi.job.COR] =
    {
        {
            { itemid = 0, droprate = 750 },
            { itemid = xi.items.CORSAIR_BULLET_POUCH, droprate = 250 },
        },
    },

    [xi.job.PUP] =
    {
        {
            { itemid = 0, droprate = 200 },
            { itemid = xi.items.ATTUNER,            droprate = 100 },
            { itemid = xi.items.TACTICAL_PROCESSOR, droprate = 100 },
            { itemid = xi.items.DRUM_MAGAZINE,      droprate = 100 },
            { itemid = xi.items.EQUALIZER,          droprate = 100 },
            { itemid = xi.items.TARGET_MAKER,       droprate = 100 },
            { itemid = xi.items.MANA_CHANNELER,     droprate = 100 },
            { itemid = xi.items.ERASER,             droprate = 100 },
            { itemid = xi.items.SMOKER_SCREEN,      droprate = 100 },
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    local bfID = player:getBattlefieldID()

    if bfID == 740 then
        local raceLoot = player:getRace()
        if raceLoot < 7 then
            if raceLoot % 2 == 0 then
                raceLoot = raceLoot - 1
            end
        end
        xi.battlefield.HandleLootRolls(battlefield, loot[raceLoot], nil, npc)

    elseif bfID == 739 then
        xi.battlefield.HandleLootRolls(battlefield, loot[player:getMainJob()], nil, npc)

    elseif battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
