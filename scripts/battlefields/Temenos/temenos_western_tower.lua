-----------------------------------
-- Area: Temenos
-- Name: Temenos Western Tower
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.TEMENOS_WESTERN_TOWER,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 2,
    area             = 3,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.keyItem.COSMO_CLEANSE, xi.keyItem.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    name             = 'TEMENOS_WESTERN_TOWER',
    lootCrateId      = ID.npc.W_LOOT_CRATE,
    timeExtension    = 15,
})

local setupItemCrate = function(crateID, floor)
    local crate = GetEntityByID(crateID)

    if crate then
        xi.limbus.hideCrate(crate)
        crate:setModelId(961)
        crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', function(player, npc)
            npcUtil.openCrate(npc, function()
                content:handleLootRolls(player:getBattlefield(), content.loot[floor], npc)
            end)
        end)
    end
end

local setupTimeCrate = function(crateID, floor)
    local crate = GetEntityByID(crateID)

    if crate then
        xi.limbus.hideCrate(crate)
        crate:setModelId(962)
        crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', utils.bind(content.handleOpenTimeCrate, content))
    end
end

local setupRecoverCrate = function(crateID, floor)
    local crate = GetEntityByID(crateID)

    if crate then
        xi.limbus.hideCrate(crate)
        crate:setModelId(960)
        crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', utils.bind(content.handleOpenRecoverCrate, content))
    end
end

function content:onBattlefieldInitialize(battlefield)
    Limbus.onBattlefieldInitialize(self, battlefield)

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

    local crateCount = battlefield:getLocalVar('CrateCount'..floor)

    if crateCount < 3 and math.random(1, 100) <= 25 then
        -- Crate type randomization happens in onBattlefieldRegister
        local crateID = ID.TEMENOS_WESTERN_TOWER.npc.CRATE_OFFSETS[floor] + crateCount

        xi.limbus.spawnFrom(mob, crateID)
        battlefield:setLocalVar('CrateCount'..floor, crateCount + 1)
    end
end

content.paths =
{
    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_TIGER + 7] =
    {
        { x =  340.000, y =  68.000, z = -104.000, wait = 10000 },
        { x =  340.000, y =  74.000, z = -139.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_TIGER + 8] =
    {
        { x =  344.000, y =  68.000, z = -100.000, wait = 10000 },
        { x =  379.000, y =  74.000, z = -100.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA] =
    {
        { x =  198.000, y = -81.000, z =  -74.000, wait = 10000 },
        { x =  198.000, y = -81.000, z =  -86.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 1] =
    {
        { x =  202.000, y = -81.000, z =  -86.000, wait = 10000 },
        { x =  202.000, y = -81.000, z =  -74.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 2] =
    {
        { x =  193.000, y = -81.000, z =  -88.000, wait = 10000 },
        { x =  207.000, y = -81.000, z =  -88.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 3] =
    {
        { x =  208.000, y = -81.000, z =  -87.000, wait = 10000 },
        { x =  208.000, y = -81.000, z =  -73.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 4] =
    {
        { x =  207.000, y = -81.000, z =  -72.000, wait = 10000 },
        { x =  193.000, y = -81.000, z =  -72.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 5] =
    {
        { x =  192.000, y = -81.000, z =  -73.000, wait = 10000 },
        { x =  192.000, y = -81.000, z =  -87.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 6] =
    {
        { x =  232.000, y = -80.000, z = -140.000, wait = 10000 },
        { x =  204.000, y = -80.000, z = -140.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 7] =
    {
        { x =  234.000, y = -80.000, z = -140.000, wait = 10000 },
        { x =  206.000, y = -80.000, z = -140.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_MANDRAGORA + 8] =
    {
        { x =  236.000, y = -80.000, z = -140.000, wait = 10000 },
        { x =  208.000, y = -80.000, z = -140.000, wait = 10000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE] =
    {
        { x =   18.000, y =  80.000, z = -140.000, wait = 30000 },
        { x =    8.000, y =  80.000, z = -140.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 1] =
    {
        { x =   20.000, y =  80.000, z = -138.000, wait = 30000 },
        { x =   20.000, y =  80.000, z = -128.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 2] =
    {
        { x =   22.000, y =  80.000, z = -140.000, wait = 30000 },
        { x =   32.000, y =  80.000, z = -140.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 3] =
    {
        { x =   58.000, y =  80.000, z = -140.000, wait = 30000 },
        { x =   48.000, y =  80.000, z = -140.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 4] =
    {
        { x =   60.000, y =  80.000, z = -138.000, wait = 30000 },
        { x =   60.000, y =  80.000, z = -128.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_BEETLE + 5] =
    {
        { x =   62.000, y =  80.000, z = -140.000, wait = 30000 },
        { x =   72.000, y =  80.000, z = -140.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD] =
    {
        { x = -152.000, y = -80.000, z = -150.500, wait =  1000 },
        { x =  -88.000, y = -80.000, z = -150.500, wait =  1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 1] =
    {
        { x = -150.000, y = -80.000, z = -147.000, wait =  5000 },
        { x = -130.000, y = -80.000, z = -147.000, wait =  5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 2] =
    {
        { x = -110.000, y = -80.000, z = -147.000, wait =  5000 },
        { x =  -90.000, y = -80.000, z = -147.000, wait =  5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 3] =
    {
        { x = -152.000, y = -80.000, z = -142.000, wait =  1000 },
        { x =  -88.000, y = -80.000, z = -142.000, wait =  1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 4] =
    {
        { x =  -88.000, y = -80.000, z = -138.000, wait =  1000 },
        { x = -152.000, y = -80.000, z = -138.000, wait =  1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 5] =
    {
        { x = -128.000, y = -80.000, z = -140.000, wait =  5000 },
        { x = -112.000, y = -80.000, z = -140.000, wait =  5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 6] =
    {
        { x = -150.000, y = -80.000, z = -133.000, wait =  5000 },
        { x = -130.000, y = -80.000, z = -133.000, wait =  5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 7] =
    {
        { x = -110.000, y = -80.000, z = -133.000, wait =  5000 },
        { x =  -90.000, y = -80.000, z = -133.000, wait =  5000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_LIZARD + 8] =
    {
        { x = -152.000, y = -80.000, z = -129.500, wait =  1000 },
        { x =  -88.000, y = -80.000, z = -129.500, wait =  1000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_SLIME + 2] =
    {
        { x = -300.000, y =  80.000, z = -148.000, wait = 30000 },
        { x = -300.000, y =  80.000, z = -132.000, wait = 30000 },
    },

    [ID.TEMENOS_WESTERN_TOWER.mob.ENHANCED_SLIME + 5] =
    {
        { x = -260.000, y =  80.000, z = -148.000, wait = 30000 },
        { x = -260.000, y =  80.000, z = -132.000, wait = 30000 },
    },
}

content.groups =
{
    {
        mobs  = { 'Armoury_Crate_Western' },
        mobMods = { [xi.mobMod.DONT_ROAM_HOME] = 1 },
        setup = function(battlefield, crates)
            for _, crate in ipairs(crates) do
                crate:setBattleID(1) -- Different battle ID prevents the crate from being hit by AOEs
            end
        end
    },

    {
        mobs     = { 'Enhanced_Tiger' },
        death    = utils.bind(content.handleMobDeath, 1),
    },

    {
        mobs     = { 'Enhanced_Mandragora' },
        mobMods  = { [xi.mobMod.LINK_RADIUS] = 8 },
        death    = utils.bind(content.handleMobDeath, 2),
    },

    {
        mobs     = { 'Enhanced_Beetle' },
        death    = utils.bind(content.handleMobDeath, 3),
    },

    {
        mobs     = { 'Enhanced_Lizard' },
        death    = utils.bind(content.handleMobDeath, 4),
    },

    {
        mobs     = { 'Enhanced_Slime' },
        death    = utils.bind(content.handleMobDeath, 5),
    },

    {
        mobs     = { 'Enhanced_Pugil' },
        death    = utils.bind(content.handleMobDeath, 6),
    },

    {
        mobs     = { 'Enhanced_Vulture' },
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetEntityByID(ID.npc.W_LOOT_CRATE))
        end,
    },
}

content.loot =
{
    [1] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },
    },

    [2] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },
    },

    [3] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },
    },

    [4] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },
    },

    [5] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },
    },

    [6] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },
    },

    [ID.npc.W_LOOT_CRATE] =
    {
        {
            quantity = 4,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 3,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight =  1000 }, -- WAR
            { itemId = xi.item.UTOPIAN_GOLD_THREAD,       weight =  1000 }, -- MNK
            { itemId = xi.item.SQUARE_OF_BENEDICT_SILK,   weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight =  1000 }, -- RDM
            { itemId = xi.item.DARK_ORICHALCUM_INGOT,     weight =  1000 }, -- DRK
            { itemId = xi.item.SQUARE_OF_SMALT_LEATHER,   weight =  1000 }, -- BST
         -- { itemId = xi.item.SQUARE_OF_BRILLIANTINE,    weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.NONE,                      weight =  4000 },
            { itemId = xi.item.SPOOL_OF_COILED_YARN,      weight =  1000 }, -- BRD
            { itemId = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight =  1000 }, -- SAM
            { itemId = xi.item.PLAITED_CORD,              weight =  1000 }, -- NIN
            { itemId = xi.item.SPOOL_OF_GLITTERING_YARN,  weight =  1000 }, -- SMN
            { itemId = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight =  1000 }, -- BLU
            { itemId = xi.item.PANTIN_WIRE,               weight =  1000 }, -- PUP
        },

        {
            { itemId = xi.item.EMERALD_CHIP,              weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  9000 },
            { itemId = xi.item.METAL_CHIP,                weight =  1000 },
        },
    },
}

return content:register()
