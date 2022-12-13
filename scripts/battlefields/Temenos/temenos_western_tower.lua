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
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 3,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =     0, weight = 100 },
            { item =  1948, weight = 172 },
            { item =  1938, weight = 138 },
            { item =  1952, weight = 138 },
            { item =  1958, weight = 207 },
            { item =  1930, weight = 241 },
            { item =  2656, weight = 172 },
        },
    },

    [2] =
    {
        {
            quantity = 5,
            { item =  1875, weight = 1000 },
        },

        {
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1948, weight = 179 },
            { item =  1938, weight = 571 },
            { item =  1944, weight =  71 },
            { item =  1952, weight = 179 },
            { item =  1946, weight = 120 },
            { item =  1934, weight =  71 },
            { item =  1930, weight = 143 },
            { item =  2660, weight = 143 },
        },

        {
            { item =     0, weight = 200 },
            { item =  1948, weight = 179 },
            { item =  1938, weight = 571 },
            { item =  1944, weight =  71 },
            { item =  1952, weight = 179 },
            { item =  1946, weight = 120 },
            { item =  1934, weight =  71 },
            { item =  1930, weight = 143 },
            { item =  2660, weight = 143 },
        },
    },

    [3] =
    {
        {
            quantity = 4,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 3,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1948, weight = 536 },
            { item =  1952, weight = 107 },
            { item =  1938, weight =  60 },
            { item =  1934, weight = 110 },
            { item =  1930, weight =  80 },
            { item =  2660, weight =  90 },
            { item =  1946, weight =  71 },
            { item =  1944, weight = 103 },
            { item =  1958, weight = 160 },
            { item =  1954, weight =  36 },
            { item =  2656, weight = 250 },
            { item =  2716, weight = 350 },
        },

        {
            { item =     0, weight = 750 },
            { item =  1948, weight = 536 },
            { item =  1952, weight = 107 },
            { item =  1938, weight =  60 },
            { item =  1934, weight = 110 },
            { item =  1930, weight =  80 },
            { item =  2660, weight =  90 },
            { item =  1946, weight =  71 },
            { item =  1944, weight = 103 },
            { item =  1958, weight = 160 },
            { item =  1954, weight =  36 },
            { item =  2656, weight = 250 },
            { item =  2716, weight = 350 },
        },
    },

    [4] =
    {
        {
            quantity = 4,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 2,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1952, weight = 533 },
            { item =  1946, weight =  90 },
            { item =  1938, weight = 133 },
            { item =  1932, weight =  90 },
            { item =  1958, weight =  10 },
            { item =  1954, weight = 133 },
            { item =  1944, weight = 133 },
            { item =  1930, weight = 133 },
            { item =  2660, weight =  33 },
        },

        {
            { item =     0, weight = 500 },
            { item =  1952, weight = 533 },
            { item =  1946, weight =  90 },
            { item =  1938, weight = 133 },
            { item =  1932, weight =  90 },
            { item =  1958, weight =  10 },
            { item =  1954, weight = 133 },
            { item =  1944, weight = 133 },
            { item =  1930, weight = 133 },
            { item =  2660, weight =  33 },
        },
    },

    [5] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            quantity = 2,
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1954, weight =  59 },
            { item =  1930, weight = 294 },
            { item =  1946, weight =  59 },
            { item =  1934, weight =  78 },
            { item =  1958, weight = 176 },
            { item =  1938, weight =  59 },
            { item =  1948, weight =  25 },
            { item =  1932, weight = 118 },
            { item =  2656, weight = 294 },
        },

        {
            { item =     0, weight = 200 },
            { item =  1954, weight =  59 },
            { item =  1930, weight = 294 },
            { item =  1946, weight =  59 },
            { item =  1934, weight =  78 },
            { item =  1958, weight = 176 },
            { item =  1938, weight =  59 },
            { item =  1948, weight =  25 },
            { item =  1932, weight = 118 },
            { item =  2656, weight = 294 },
        },
    },

    [6] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1954, weight = 200 },
            { item =  1958, weight = 400 },
            { item =  1948, weight = 100 },
            { item =  1934, weight = 150 },
            { item =  1932, weight =  50 },
            { item =  1930, weight =  60 },
            { item =  1938, weight = 200 },
            { item =  1944, weight =  60 },
            { item =  1952, weight = 200 },
        },

        {
            { item =     0, weight = 400 },
            { item =  1954, weight = 200 },
            { item =  1958, weight = 400 },
            { item =  1948, weight = 100 },
            { item =  1934, weight = 150 },
            { item =  1932, weight =  50 },
            { item =  1930, weight =  60 },
            { item =  1938, weight = 200 },
            { item =  1944, weight =  60 },
            { item =  1952, weight = 200 },
        },
    },

    [ID.TEMENOS_WESTERN_TOWER.npc.LOOT_CRATE] =
    {
        {
            quantity = 6,
            { item =  1875, weight = 1000 },
        },

        {
            { item =     0, weight = 1000 },
            { item =  1875, weight = 1000 },
        },

        {
            { item =  1948, weight =  36 },
            { item =  1952, weight = 143 },
            { item =  1930, weight = 143 },
            { item =  1958, weight = 214 },
            { item =  1938, weight =  71 },
            { item =  2656, weight = 321 },
        },

        {
            { item =  1906, weight = 1000 },
        },

        {
            { item =     0, weight = 100 },
            { item =  2127, weight =  55 },
        },
    },
}

return content:register()
