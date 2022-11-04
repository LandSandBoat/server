-----------------------------------
-- Area: Temenos
-- Name: Temenos Western Tower
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.TEMENOS_WESTERN_TOWER,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    area             = 3,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    name             = "TEMENOS_WESTERN_TOWER",
    timeExtension    = 15,
})

local setupItemCrate = function(crateID, floor)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(961)
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", function(player, npc)
        npcUtil.openCrate(npc, function()
            content:handleLootRolls(player:getBattlefield(), content.loot[floor], npc)
        end)
    end)
end

local setupTimeCrate = function(crateID, floor)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(962)
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", utils.bind(content.handleOpenTimeCrate, content))
end

local setupRecoverCrate = function(crateID, floor)
    local crate = GetEntityByID(crateID)
    xi.limbus.hideCrate(crate)
    crate:setModelId(960)
    crate:addListener("ON_TRIGGER", "TRIGGER_CRATE", utils.bind(content.handleOpenRecoverCrate, content))
end

function content:onBattlefieldInitialise(battlefield)
    Limbus.onBattlefieldInitialise(self, battlefield)

    local crateSetupFuncs =
    {
        setupItemCrate,
        setupTimeCrate,
        setupRecoverCrate,
    }

    -- Crates are always spawned with sequential IDs
    -- Randomize crate type order by shuffling setup functions
    for floor, crateOffset in ipairs(ID.TEMENOS_WESTERN_TOWER.npc.CRATE_OFFSETS) do
        local setupFuncs = utils.shuffle(crateSetupFuncs)
        for i = 0, 2 do
            setupFuncs[i + 1](crateOffset + i, floor)
        end
    end
end

content.handleMobDeath = function(floor, battlefield, mob, count)
    content:openDoor(battlefield, floor)

    local crateCount = battlefield:getLocalVar("CrateCount"..floor)
    if crateCount < 3 and math.random(4) == 1 then
        -- Crate type randomization happens in onBattlefieldRegister
        local crateID = ID.TEMENOS_WESTERN_TOWER.npc.CRATE_OFFSETS[floor] + crateCount
        xi.limbus.spawnFrom(mob, crateID)
        battlefield:setLocalVar("CrateCount"..floor, crateCount + 1)
    end
end

content.paths =
{
    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_TIGER + 7] =
    {
        { x = 340.0, y = 68.0, z = -104.0, wait = 10000 },
        { x = 340.0, y = 74.0, z = -139.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_TIGER + 8] =
    {
        { x = 344.0, y = 68.0, z = -100.0, wait = 10000 },
        { x = 379.0, y = 74.0, z = -100.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA] =
    {
        { x = 198.0, y = -81.0, z = -74.0, wait = 10000 },
        { x = 198.0, y = -81.0, z = -86.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 1] =
    {
        { x = 202.0, y = -81.0, z = -86.0, wait = 10000 },
        { x = 202.0, y = -81.0, z = -74.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 2] =
    {
        { x = 193.0, y = -81.0, z = -88.0, wait = 10000 },
        { x = 207.0, y = -81.0, z = -88.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 3] =
    {
        { x = 208.0, y = -81.0, z = -87.0, wait = 10000 },
        { x = 208.0, y = -81.0, z = -73.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 4] =
    {
        { x = 207.0, y = -81.0, z = -72.0, wait = 10000 },
        { x = 193.0, y = -81.0, z = -72.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 5] =
    {
        { x = 192.0, y = -81.0, z = -73.0, wait = 10000 },
        { x = 192.0, y = -81.0, z = -87.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 6] =
    {
        { x = 232.0, y = -80.0, z = -140.0, wait = 10000 },
        { x = 204.0, y = -80.0, z = -140.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 7] =
    {
        { x = 234.0, y = -80.0, z = -140.0, wait = 10000 },
        { x = 206.0, y = -80.0, z = -140.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 8] =
    {
        { x = 236.0, y = -80.0, z = -140.0, wait = 10000 },
        { x = 208.0, y = -80.0, z = -140.0, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE] =
    {
        { x = 18.0, y = 80.0, z = -140.0, wait = 30000 },
        { x = 8.0, y = 80.0, z = -140.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 1] =
    {
        { x = 20.0, y = 80.0, z = -138.0, wait = 30000 },
        { x = 20.0, y = 80.0, z = -128.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 2] =
    {
        { x = 22.0, y = 80.0, z = -140.0, wait = 30000 },
        { x = 32.0, y = 80.0, z = -140.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 3] =
    {
        { x = 58.0, y = 80.0, z = -140.0, wait = 30000 },
        { x = 48.0, y = 80.0, z = -140.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 4] =
    {
        { x = 60.0, y = 80.0, z = -138.0, wait = 30000 },
        { x = 60.0, y = 80.0, z = -128.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 5] =
    {
        { x = 62.0, y = 80.0, z = -140.0, wait = 30000 },
        { x = 72.0, y = 80.0, z = -140.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD] =
    {
        { x = -152.0, y = -80.0, z = -150.50, wait = 1000 },
        { x = -88.0, y = -80.0, z = -150.50, wait = 1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 1] =
    {
        { x = -150.0, y = -80.0, z = -147.0, wait = 5000 },
        { x = -130.0, y = -80.0, z = -147.0, wait = 5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 2] =
    {
        { x = -110.0, y = -80.0, z = -147.0, wait = 5000 },
        { x = -90.0, y = -80.0, z = -147.0, wait = 5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 3] =
    {
        { x = -152.0, y = -80.0, z = -142.0, wait = 1000 },
        { x = -88.0, y = -80.0, z = -142.0, wait = 1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 4] =
    {
        { x = -88.0, y = -80.0, z = -138.0, wait = 1000 },
        { x = -152.0, y = -80.0, z = -138.0, wait = 1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 5] =
    {
        { x = -128.0, y = -80.0, z = -140.0, wait = 5000 },
        { x = -112.0, y = -80.0, z = -140.0, wait = 5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 6] =
    {
        { x = -150.0, y = -80.0, z = -133.0, wait = 5000 },
        { x = -130.0, y = -80.0, z = -133.0, wait = 5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 7] =
    {
        { x = -110.0, y = -80.0, z = -133.0, wait = 5000 },
        { x = -90.0, y = -80.0, z = -133.0, wait = 5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 8] =
    {
        { x = -152.0, y = -80.0, z = -129.50, wait = 1000 },
        { x = -88.0, y = -80.0, z = -129.50, wait = 1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_SLIME + 2] =
    {
        { x = -300.0, y = 80.0, z = -148.0, wait = 30000 },
        { x = -300.0, y = 80.0, z = -132.0, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_SLIME + 5] =
    {
        { x = -260.0, y = 80.0, z = -148.0, wait = 30000 },
        { x = -260.0, y = 80.0, z = -132.0, wait = 30000 },
    },
}

content.groups =
{
    {
        mobs = { "Armoury_Crate_Western" },
        setup = function(battlefield, crates)
            for _, crate in ipairs(crates) do
                crate:setBattleID(1) -- Different battle ID prevents the crate from being hit by AOEs
            end
        end
    },

    {
        mobs = { "Enhanced_Tiger" },
        death = utils.bind(content.handleMobDeath, 1),
    },

    {
        mobs = { "Enhanced_Mandragora" },
        mobMods = { [xi.mobMod.LINK_RADIUS] = 8 },
        death = utils.bind(content.handleMobDeath, 2),
    },

    {
        mobs = { "Enhanced_Beetle" },
        death = utils.bind(content.handleMobDeath, 3),
    },

    {
        mobs = { "Enhanced_Lizard" },
        death = utils.bind(content.handleMobDeath, 4),
    },

    {
        mobs = { "Enhanced_Slime" },
        death = utils.bind(content.handleMobDeath, 5),
    },

    {
        mobs = { "Enhanced_Pugil" },
        death = utils.bind(content.handleMobDeath, 6),
    },

    {
        mobs = { "Enhanced_Vulture" },
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetEntityByID(ID.TEMENOS_WESTERN_TOWER.npc.LOOT_CRATE))
        end,
    },
}

content.loot =
{
    [1] =
    {
        {
            quantity = 5,
            { itemid = 1875, droprate = 1000 },
        },

        {
            quantity = 3,
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid =    0, droprate = 100 },
            { itemid = 1948, droprate = 172 },
            { itemid = 1938, droprate = 138 },
            { itemid = 1952, droprate = 138 },
            { itemid = 1958, droprate = 207 },
            { itemid = 1930, droprate = 241 },
            { itemid = 2656, droprate = 172 },
        },
    },

    [2] =
    {
        {
            quantity = 5,
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1948, droprate = 179 },
            { itemid = 1938, droprate = 571 },
            { itemid = 1944, droprate =  71 },
            { itemid = 1952, droprate = 179 },
            { itemid = 1946, droprate = 120 },
            { itemid = 1934, droprate =  71 },
            { itemid = 1930, droprate = 143 },
            { itemid = 2660, droprate = 143 },
        },

        {
            { itemid =    0, droprate = 200 },
            { itemid = 1948, droprate = 179 },
            { itemid = 1938, droprate = 571 },
            { itemid = 1944, droprate =  71 },
            { itemid = 1952, droprate = 179 },
            { itemid = 1946, droprate = 120 },
            { itemid = 1934, droprate =  71 },
            { itemid = 1930, droprate = 143 },
            { itemid = 2660, droprate = 143 },
        },
    },

    [3] =
    {
        {
            quantity = 4,
            { itemid = 1875, droprate = 1000 },
        },

        {
            quantity = 3,
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1948, droprate = 536 },
            { itemid = 1952, droprate = 107 },
            { itemid = 1938, droprate =  60 },
            { itemid = 1934, droprate = 110 },
            { itemid = 1930, droprate =  80 },
            { itemid = 2660, droprate =  90 },
            { itemid = 1946, droprate =  71 },
            { itemid = 1944, droprate = 103 },
            { itemid = 1958, droprate = 160 },
            { itemid = 1954, droprate =  36 },
            { itemid = 2656, droprate = 250 },
            { itemid = 2716, droprate = 350 },
        },

        {
            { itemid =    0, droprate = 750 },
            { itemid = 1948, droprate = 536 },
            { itemid = 1952, droprate = 107 },
            { itemid = 1938, droprate =  60 },
            { itemid = 1934, droprate = 110 },
            { itemid = 1930, droprate =  80 },
            { itemid = 2660, droprate =  90 },
            { itemid = 1946, droprate =  71 },
            { itemid = 1944, droprate = 103 },
            { itemid = 1958, droprate = 160 },
            { itemid = 1954, droprate =  36 },
            { itemid = 2656, droprate = 250 },
            { itemid = 2716, droprate = 350 },
        },
    },

    [4] =
    {
        {
            quantity = 4,
            { itemid = 1875, droprate = 1000 },
        },

        {
            quantity = 2,
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1952, droprate = 533 },
            { itemid = 1946, droprate =  90 },
            { itemid = 1938, droprate = 133 },
            { itemid = 1932, droprate =  90 },
            { itemid = 1958, droprate =  10 },
            { itemid = 1954, droprate = 133 },
            { itemid = 1944, droprate = 133 },
            { itemid = 1930, droprate = 133 },
            { itemid = 2660, droprate =  33 },
        },

        {
            { itemid =    0, droprate = 500 },
            { itemid = 1952, droprate = 533 },
            { itemid = 1946, droprate =  90 },
            { itemid = 1938, droprate = 133 },
            { itemid = 1932, droprate =  90 },
            { itemid = 1958, droprate =  10 },
            { itemid = 1954, droprate = 133 },
            { itemid = 1944, droprate = 133 },
            { itemid = 1930, droprate = 133 },
            { itemid = 2660, droprate =  33 },
        },
    },

    [5] =
    {
        {
            quantity = 6,
            { itemid = 1875, droprate = 1000 },
        },

        {
            quantity = 2,
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1954, droprate =  59 },
            { itemid = 1930, droprate = 294 },
            { itemid = 1946, droprate =  59 },
            { itemid = 1934, droprate =  78 },
            { itemid = 1958, droprate = 176 },
            { itemid = 1938, droprate =  59 },
            { itemid = 1948, droprate =  25 },
            { itemid = 1932, droprate = 118 },
            { itemid = 2656, droprate = 294 },
        },

        {
            { itemid =    0, droprate = 200 },
            { itemid = 1954, droprate =  59 },
            { itemid = 1930, droprate = 294 },
            { itemid = 1946, droprate =  59 },
            { itemid = 1934, droprate =  78 },
            { itemid = 1958, droprate = 176 },
            { itemid = 1938, droprate =  59 },
            { itemid = 1948, droprate =  25 },
            { itemid = 1932, droprate = 118 },
            { itemid = 2656, droprate = 294 },
        },
    },

    [6] =
    {
        {
            quantity = 6,
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1954, droprate = 200 },
            { itemid = 1958, droprate = 400 },
            { itemid = 1948, droprate = 100 },
            { itemid = 1934, droprate = 150 },
            { itemid = 1932, droprate =  50 },
            { itemid = 1930, droprate =  60 },
            { itemid = 1938, droprate = 200 },
            { itemid = 1944, droprate =  60 },
            { itemid = 1952, droprate = 200 },
        },

        {
            { itemid =    0, droprate = 400 },
            { itemid = 1954, droprate = 200 },
            { itemid = 1958, droprate = 400 },
            { itemid = 1948, droprate = 100 },
            { itemid = 1934, droprate = 150 },
            { itemid = 1932, droprate =  50 },
            { itemid = 1930, droprate =  60 },
            { itemid = 1938, droprate = 200 },
            { itemid = 1944, droprate =  60 },
            { itemid = 1952, droprate = 200 },
        },
    },

    [ID.TEMENOS_WESTERN_TOWER.npc.LOOT_CRATE] =
    {
        {
            quantity = 6,
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid =    0, droprate = 1000 },
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1948, droprate =  36 },
            { itemid = 1952, droprate = 143 },
            { itemid = 1930, droprate = 143 },
            { itemid = 1958, droprate = 214 },
            { itemid = 1938, droprate =  71 },
            { itemid = 2656, droprate = 321 },
        },

        {
            { itemid = 1906, droprate = 1000 },
        },

        {
            { itemid =    0, droprate = 100 },
            { itemid = 2127, droprate =  55 },
        },
    },
}

return content:register()
