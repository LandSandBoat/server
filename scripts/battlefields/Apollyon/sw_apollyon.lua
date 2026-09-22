-----------------------------------
-- Area: Apollyon
-- Name: SW Apollyon
-- !addkeyitem red_card
-- !addkeyitem cosmo_cleanse
-- !pos -600 -0.5 -600 38
-----------------------------------
local ID = zones[xi.zone.APOLLYON]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.SW_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 0,
    area             = 1,
    entryNpc         = '_127',
    requiredKeyItems = { xi.keyItem.COSMO_CLEANSE, xi.keyItem.RED_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    name             = 'SW_APOLLYON',
    lootCrateId      = ID.npc.SW_LOOT_CRATE,
    timeExtension    = 10,
})

function content:onBattlefieldRegister(player, battlefield)
    Limbus.onBattlefieldRegister(self, player, battlefield)

    -- Get the initiator's race for the first floor. Convert to male since that's what mobs are using.
    local race = player:getRace()

    if race == xi.race.ELVAAN_F then
        race = xi.race.ELVAAN_M
    elseif race == xi.race.HUME_F then
        race = xi.race.HUME_M
    elseif race == xi.race.TARU_F then
        race = xi.race.TARU_M
    end

    battlefield:setLocalVar('initiatorRace', race)

    -- Randomize whether door opens first (0) or crates spawn first (1)
    battlefield:setLocalVar('doorFirst', math.random(0, 1))
end

content.sections =
{
    {
        [xi.zone.APOLLYON] =
        {
            onEventFinish =
            {
                [207] = function(player, csid, option, npc)
                    local battlefield = player:getBattlefield()

                    if battlefield:getLocalVar('weather') == 0 then
                        battlefield:setLocalVar('weather', VanadielDayElement())
                    end
                end
            }
        }
    }
}

local checkRaceEvent = function(mobRace, isFirstKill, battlefield, mob)
    local race = battlefield:getLocalVar('initiatorRace')

    if race ~= mobRace then
        return
    end

    local doorFirst = battlefield:getLocalVar('doorFirst') == 0

    if doorFirst == isFirstKill then
        content:openDoor(mob:getBattlefield(), 1)
    else
        npcUtil.showCrate(GetNPCByID(ID.SW_APOLLYON.npc.ITEM_CRATES[1]))
        npcUtil.showCrate(GetNPCByID(ID.SW_APOLLYON.npc.TIME_CRATES[1]))
        xi.limbus.showRecoverCrate(ID.SW_APOLLYON.npc.RECOVER_CRATES[1])
    end
end

local checkElementalCrate = function(mobElement, battlefield, mob)
    local weatherElement = battlefield:getLocalVar('weather')

    if weatherElement == mobElement then
        npcUtil.showCrate(GetNPCByID(ID.npc.SW_LOOT_CRATE))
    end
end

local revealMimic = function(mimic, target)
    if mimic:getLocalVar('disguised') == 0 then
        return
    end

    local battlefield = mimic:getBattlefield()
    battlefield:setLocalVar('disguisedMimics', battlefield:getLocalVar('disguisedMimics') - 1)

    mimic:setLocalVar('disguised', 0)
    mimic:hideName(false)
    mimic:setStatus(xi.status.UPDATE)
    mimic:setAnimationSub(1)
    mimic:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mimic:setBattleID(0)
    mimic:updateClaim(target)
    mimic:updateEnmity(target)
end

-- Set up floor 3 chests after Limbus initialization since it hides all crates
function content:onBattlefieldInitialize(battlefield)
    Limbus.onBattlefieldInitialize(self, battlefield)

    local mimics = {}

    for offset = 0, 9 do
        table.insert(mimics, GetMobByID(ID.mob.SW_ARMOURY_CRATE_MIMIC_OFFSET + offset))
    end

    local shuffled = utils.shuffle(mimics)

    -- Three chests are real crates; each replaces its despawned mimic
    local placeCrate = function(mimic, crate)
        crate:setPos(mimic:getXPos(), mimic:getYPos(), mimic:getZPos(), mimic:getRotPos())
        crate:setModelId(961)
        crate:setAnimationSub(8)
        npcUtil.showCrate(crate)
        DespawnMob(mimic:getID())
    end

    placeCrate(shuffled[1], GetNPCByID(ID.SW_APOLLYON.npc.TIME_CRATES[3]))
    placeCrate(shuffled[2], GetNPCByID(ID.SW_APOLLYON.npc.ITEM_CRATES[3]))
    placeCrate(shuffled[3], GetMobByID(ID.SW_APOLLYON.npc.RECOVER_CRATES[3]))

    battlefield:setLocalVar('disguisedMimics', #shuffled - 3)

    for i = 4, #shuffled do
        local mob = shuffled[i]

        mob:setLocalVar('disguised', 1)
        mob:hideName(true)
        mob:setStatus(xi.status.NORMAL)
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
        mob:setMobMod(xi.mobMod.NO_LINK, 1)
        mob:setAnimationSub(0)
        mob:setBattleID(1) -- Different battle ID blocks all player attacks while disguised

        mob:addListener('ON_TRIGGER', 'TRIGGER_MIMIC', function(player, npc)
            revealMimic(npc, player)
        end)
    end
end

-- Disguised mimics turn aggressive when a player comes within 5 yalms
function content:onBattlefieldTick(battlefield, tick)
    Limbus.onBattlefieldTick(self, battlefield, tick)

    -- Skip scanning until the mimic floor is reachable and while mimics remain disguised
    if
        battlefield:getLocalVar('floor2DoorOpened') == 0 or
        battlefield:getLocalVar('disguisedMimics') == 0
    then
        return
    end

    local players = battlefield:getPlayers()

    for offset = 0, 9 do
        local mimic = GetMobByID(ID.mob.SW_ARMOURY_CRATE_MIMIC_OFFSET + offset)

        if
            mimic and
            mimic:isSpawned() and
            mimic:getLocalVar('disguised') == 1
        then
            for _, player in pairs(players) do
                if
                    player:isAlive() and
                    mimic:checkDistance(player) <= 5
                then
                    revealMimic(mimic, player)
                    break
                end
            end
        end
    end
end

content.paths =
{
    [ID.mob.SW_AIR_ELEMENTAL_OFFSET] =
    {
        { x = -613.0, y =  0.0, z = -373.0, wait = 7500 },
        { x = -602.0, y =  0.0, z = -369.0, wait = 7500 },
    },

    [ID.mob.SW_AIR_ELEMENTAL_OFFSET + 8] =
    {
        { x = -591.0, y =  0.0, z = -374.0, wait = 7500 },
        { x = -602.0, y =  0.0, z = -369.0, wait = 7500 },
    },

    [ID.mob.SW_AIR_ELEMENTAL_OFFSET + 16] =
    {
        { x = -602.0, y =  0.0, z = -369.0, wait = 7500 },
        { x = -599.0, y =  0.0, z = -368.0, wait = 7500 },
    },

    [ID.mob.SW_DARK_ELEMENTAL_OFFSET] =
    {
        { x = -611.0, y =  0.0, z = -376.0, wait = 7500 },
        { x = -585.0, y = -0.5, z = -365.0, wait = 7500 },
    },

    [ID.mob.SW_DARK_ELEMENTAL_OFFSET + 8] =
    {
        { x = -574.0, y =  0.0, z = -363.0, wait = 7500 },
        { x = -585.0, y =  0.0, z = -365.0, wait = 7500 },
    },

    [ID.mob.SW_DARK_ELEMENTAL_OFFSET + 16] =
    {
        { x = -585.0, y =  0.0, z = -365.0, wait = 7500 },
        { x = -615.0, y =  0.0, z = -371.0, wait = 7500 },
    },

    [ID.mob.SW_EARTH_ELEMENTAL_OFFSET] =
    {
        { x = -571.0, y =  0.0, z = -328.0, wait = 7500 },
        { x = -561.0, y =  0.0, z = -323.0, wait = 7500 },
    },

    [ID.mob.SW_EARTH_ELEMENTAL_OFFSET + 8] =
    {
        { x = -581.0, y =  0.0, z = -340.0, wait = 7500 },
        { x = -571.0, y =  0.0, z = -328.0, wait = 7500 },
    },

    [ID.mob.SW_EARTH_ELEMENTAL_OFFSET + 16] =
    {
        { x = -571.0, y =  0.0, z = -328.0, wait = 7500 },
        { x = -556.0, y =  0.0, z = -330.0, wait = 7500 },
    },

    [ID.mob.SW_FIRE_ELEMENTAL_OFFSET] =
    {
        { x = -557.0, y =  0.0, z = -359.0, wait = 7500 },
        { x = -531.0, y =  0.0, z = -343.0, wait = 7500 },
    },

    [ID.mob.SW_FIRE_ELEMENTAL_OFFSET + 8] =
    {
        { x = -531.0, y =  0.0, z = -343.0, wait = 7500 },
        { x = -530.0, y =  0.0, z = -325.0, wait = 7500 },
    },

    [ID.mob.SW_FIRE_ELEMENTAL_OFFSET + 16] =
    {
        { x = -537.0, y =  0.0, z = -358.0, wait = 7500 },
        { x = -531.0, y =  0.0, z = -343.0, wait = 7500 },
    },

    [ID.mob.SW_ICE_ELEMENTAL_OFFSET] =
    {
        { x = -595.0, y =  0.0, z = -388.0, wait = 7500 },
        { x = -590.0, y =  0.0, z = -372.0, wait = 7500 },
    },

    [ID.mob.SW_ICE_ELEMENTAL_OFFSET + 8] =
    {
        { x = -607.0, y =  0.0, z = -397.0, wait = 7500 },
        { x = -595.0, y =  0.0, z = -388.0, wait = 7500 },
    },

    [ID.mob.SW_ICE_ELEMENTAL_OFFSET + 16] =
    {
        { x = -595.0, y =  0.0, z = -388.0, wait = 7500 },
        { x = -593.0, y =  0.0, z = -367.0, wait = 7500 },
    },

    [ID.mob.SW_LIGHT_ELEMENTAL_OFFSET] =
    {
        { x = -547.0, y =  0.0, z = -366.0, wait = 7500 },
        { x = -560.0, y =  0.0, z = -362.0, wait = 7500 },
    },

    [ID.mob.SW_LIGHT_ELEMENTAL_OFFSET + 8] =
    {
        { x = -565.0, y =  0.0, z = -351.0, wait = 7500 },
        { x = -547.0, y =  0.0, z = -366.0, wait = 7500 },
    },

    [ID.mob.SW_LIGHT_ELEMENTAL_OFFSET + 16] =
    {
        { x = -583.0, y =  0.0, z = -370.0,  wait = 7500 },
        { x = -551.0, y =  0.0, z = -366.44, wait = 7500 },
    },

    [ID.mob.SW_WATER_ELEMENTAL_OFFSET] =
    {
        { x = -574.0, y =  0.0, z = -377.0, wait = 7500 },
        { x = -570.0, y =  0.0, z = -346.0, wait = 7500 },
    },

    [ID.mob.SW_WATER_ELEMENTAL_OFFSET + 8] =
    {
        { x = -576.0, y =  0.0, z = -377.0, wait = 7500 },
        { x = -570.0, y =  0.0, z = -346.0, wait = 7500 },
    },

    [ID.mob.SW_WATER_ELEMENTAL_OFFSET + 16] =
    {
        { x = -570.0, y =  0.0, z = -346.0, wait = 7500 },
        { x = -574.0, y =  0.0, z = -379.0, wait = 7500 },
    },

    [ID.mob.SW_THUNDER_ELEMENTAL_OFFSET] =
    {
        { x = -569.0, y =  0.0, z = -346.0, wait = 7500 },
        { x = -605.0, y =  0.0, z = -343.0, wait = 7500 },
    },

    [ID.mob.SW_THUNDER_ELEMENTAL_OFFSET + 8] =
    {
        { x = -569.0, y =  0.0, z = -346.0, wait = 7500 },
        { x = -594.0, y =  0.0, z = -344.0, wait = 7500 },
    },

    [ID.mob.SW_THUNDER_ELEMENTAL_OFFSET + 16] =
    {
        { x = -569.0, y =  0.0, z = -346.0, wait = 7500 },
        { x = -617.0, y =  0.0, z = -344.0, wait = 7500 },
    }
}

content.groups =
{
    -- Floor 1
    {
        mobs        = { 'Fir_Bholg_THF' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceEvent, xi.race.ELVAAN_M, true),
        allDeath    = utils.bind(checkRaceEvent, xi.race.ELVAAN_M, false),
    },

    {
        mobs        = { 'Fir_Bholg_PLD' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceEvent, xi.race.GALKA, true),
        allDeath    = utils.bind(checkRaceEvent, xi.race.GALKA, false),
    },

    {
        mobs        = { 'Fir_Bholg_SAM' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceEvent, xi.race.HUME_M, true),
        allDeath    = utils.bind(checkRaceEvent, xi.race.HUME_M, false),
    },

    {
        mobs        = { 'Fir_Bholg_RDM' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceEvent, xi.race.MITHRA, true),
        allDeath    = utils.bind(checkRaceEvent, xi.race.MITHRA, false),
    },

    {
        mobs        = { 'Fir_Bholg_BLM' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceEvent, xi.race.TARU_M, true),
        allDeath    = utils.bind(checkRaceEvent, xi.race.TARU_M, false),
    },

    -- Floor 2
    {
        mobs    = { 'Jidra_Boss' },
        stationary = true,
        death = function(battlefield, mob, count)
            battlefield:setLocalVar('floor2DoorOpened', 1)
            content:openDoor(battlefield, 2)
        end,
    },

    {
        mobs    = { 'Jidra' },
        stationary = true,
        setup = function(battlefield, mobs)
            local positions =
            {
                { x = -222.52, y = -0.50, z = -414.11, rot =  38 },
                { x = -150.90, y = -0.50, z = -507.21, rot =  65 },
                { x = -101.32, y = -0.50, z = -582.85, rot = 158 },
                { x = -114.74, y = -0.50, z = -470.75, rot =  91 },
                { x = -202.64, y = -0.50, z = -484.55, rot = 207 },
                { x = -117.56, y = -0.50, z = -516.36, rot = 117 },
                { x = -197.58, y = -0.50, z = -593.41, rot =  39 },
                { x = -176.13, y = -0.60, z = -560.06, rot = 112 },
            }

            positions = utils.shuffle(positions)

            for i, mob in ipairs(mobs) do
                local position = positions[i]
                mob:setSpawn(position.x, position.y, position.z, position.rot)
                mob:setPos(position.x, position.y, position.z, position.rot)
            end

            local position = positions[#positions]
            local bossMob  = GetMobByID(ID.mob.SW_BOSS_JIDRA)
            if bossMob then
                bossMob:setSpawn(position.x, position.y, position.z, position.rot)
                bossMob:setPos(position.x, position.y, position.z, position.rot)
            end
        end,

        death = function(battlefield, mob, count)
            local addID = mob:getID() + 7
            local add   = GetMobByID(addID)

            if add then
                add:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                SpawnMob(addID)

                local enmityList = mob:getEnmityList()
                local entry      = utils.randomEntry(enmityList)

                if
                    entry and
                    entry.entity
                then
                    add:updateEnmity(entry.entity)
                end
            end
        end,
    },

    {
        -- Jidra (Adds)
        mobs =
        {
            'Arboricole_Hornet',
            'Arboricole_Raven',
            'Arboricole_Opo-opo',
            'Arboricole_Spider',
            'Arboricole_Beetle',
            'Arboricole_Crawler',
            'Apollyon_Sapling',
        },

        spawned = false,
        stationary = true,
        setup = function(battlefield, mobs)
            -- Select one mob to have buffed HP
            local buffableMobs = {}
            for _, mob in ipairs(mobs) do
                local name = mob:getName()
                if name ~= 'Arboricole_Raven' then
                    table.insert(buffableMobs, mob)
                end
            end

            -- Spawning recalculates stats, so the buff must be applied post-spawn
            local buffedMob = buffableMobs[math.randomInt(1, #buffableMobs)]
            buffedMob:addListener('SPAWN', 'BUFFED_HP_SPAWN', function(mobArg)
                mobArg:setMaxHP(8500)
                mobArg:setHP(8500)
            end)
        end,

        death = function(battlefield, mob)
            -- Set a fresh variable on battlefield creation and increment it for each enemy killed.
            local kills = battlefield:getLocalVar('floorTwoEnemiesDefeated') + 1
            battlefield:setLocalVar('floorTwoEnemiesDefeated', kills)

            if kills == 7 then
                npcUtil.showCrate(GetNPCByID(ID.SW_APOLLYON.npc.ITEM_CRATES[2]))
                npcUtil.showCrate(GetNPCByID(ID.SW_APOLLYON.npc.TIME_CRATES[2]))
                xi.limbus.showRecoverCrate(ID.SW_APOLLYON.npc.RECOVER_CRATES[2])
            end
        end,
    },

    -- Floor 3
    {
        mobs  = { 'Armoury_Crate_Mimic' },
        death = function(battlefield, mob)
            if battlefield:getLocalVar('floor3DoorOpened') == 0 then
                battlefield:setLocalVar('floor3DoorOpened', 1)
                content:openDoor(battlefield, 3)
            end
        end
    },

    -- Floor 4
    {
        mobs      = { 'Air_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate, xi.element.WIND),
    },

    {
        mobs      = { 'Dark_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.DARK),
    },

    {
        mobs      = { 'Earth_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.EARTH),
    },

    {
        mobs      = { 'Fire_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.FIRE),
    },

    {
        mobs      = { 'Ice_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.ICE),
    },

    {
        mobs      = { 'Light_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.LIGHT),
    },

    {
        mobs      = { 'Water_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.WATER),
    },

    {
        mobs      = { 'Thunder_Elemental' },
        isParty   = true,
        superlink = true,
        allDeath  = utils.bind(checkElementalCrate,  xi.element.THUNDER),
    },
}

content.loot =
{
    [ID.SW_APOLLYON.npc.ITEM_CRATES[1]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },
    },

    [ID.SW_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },
    },

    [ID.SW_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            quantity = 2,
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },

        {
            quantity = 2,
            { itemId = xi.item.NONE,                      weight = 10000 },
            { itemId = xi.item.CHUNK_OF_ADAMAN_ORE,       weight =  1000 },
            { itemId = xi.item.HANDFUL_OF_CLOT_PLASMA,    weight =  1000 },
            { itemId = xi.item.DARKSTEEL_SHEET,           weight =  1000 },
            { itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE,    weight =  1000 },
            { itemId = xi.item.PIECE_OF_OXBLOOD,          weight =  1000 },
            { itemId = xi.item.LIGHT_STEEL_INGOT,         weight =  1000 },
            { itemId = xi.item.SPOOL_OF_RAINBOW_THREAD,   weight =  1000 },
            { itemId = xi.item.PONZE_OF_SHELL_POWDER,     weight =  1000 },
        },
    },

    [ID.npc.SW_LOOT_CRATE] =
    {
        {
            quantity = 5,
            { itemId = xi.item.ANCIENT_BEASTCOIN,         weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.ARGYRO_RIVET,              weight =  1000 }, -- WAR
            { itemId = xi.item.ANCIENT_BRASS_INGOT,       weight =  1000 }, -- MNK
            { itemId = xi.item.SPOOL_OF_BENEDICT_YARN,    weight =  1000 }, -- WHM
            { itemId = xi.item.SPOOL_OF_DIABOLIC_YARN,    weight =  1000 }, -- BLM
            { itemId = xi.item.SQUARE_OF_CARDINAL_CLOTH,  weight =  1000 }, -- RDM
            { itemId = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight =  1000 }, -- THF
            { itemId = xi.item.WHITE_RIVET,               weight =  1000 }, -- PLD
            { itemId = xi.item.BLACK_RIVET,               weight =  1000 }, -- DRK
            { itemId = xi.item.FETID_LANOLIN_CUBE,        weight =  1000 }, -- BST
         -- { itemId = xi.item.GOLD_STUD,                 weight =  1000 }, -- DNC
        },

        {
            { itemId = xi.item.NONE,                      weight =  3000 },
            { itemId = xi.item.SQUARE_OF_BROWN_DOESKIN,   weight =  1000 }, -- BRD
            { itemId = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight =  1000 }, -- RNG
            { itemId = xi.item.SHEET_OF_KUROGANE,         weight =  1000 }, -- SAM
            { itemId = xi.item.POT_OF_EBONY_LACQUER,      weight =  1000 }, -- NIN
            { itemId = xi.item.BLUE_RIVET,                weight =  1000 }, -- DRG
            { itemId = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight =  1000 }, -- SMN
            { itemId = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight =  1000 }, -- BLU
            { itemId = xi.item.SQUARE_OF_CANVAS_TOILE,    weight =  1000 }, -- COR
            { itemId = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight =  1000 }, -- PUP
         -- { itemId = xi.item.ELECTRUM_STUD,             weight =  1000 }, -- SCH
        },

        {
            { itemId = xi.item.CHARCOAL_CHIP,             weight = 10000 },
        },

        {
            { itemId = xi.item.NONE,                      weight = 10000 },
            { itemId = xi.item.METAL_CHIP,                weight =  1000 },
        },
    },
}

return content:register()
