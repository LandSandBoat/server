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
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.RED_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
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

local checkRaceVortex = function(mobRace, battlefield, mob)
    local race = battlefield:getLocalVar('initiatorRace')

    if race == mobRace then
        content:openDoor(mob:getBattlefield(), 1)
    end
end

local checkRaceCrates = function(mobRace, battlefield, mob)
    local race = battlefield:getLocalVar('initiatorRace')

    if race == mobRace then
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
        randomDeath = utils.bind(checkRaceVortex, xi.race.ELVAAN_M),
        allDeath    = utils.bind(checkRaceCrates, xi.race.ELVAAN_M),
    },

    {
        mobs        = { 'Fir_Bholg_PLD' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceVortex, xi.race.GALKA),
        allDeath    = utils.bind(checkRaceCrates, xi.race.GALKA),
    },

    {
        mobs        = { 'Fir_Bholg_SAM' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceVortex, xi.race.HUME_M),
        allDeath    = utils.bind(checkRaceCrates, xi.race.HUME_M),
    },

    {
        mobs        = { 'Fir_Bholg_RDM' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceVortex, xi.race.MITHRA),
        allDeath    = utils.bind(checkRaceCrates, xi.race.MITHRA),
    },

    {
        mobs        = { 'Fir_Bholg_BLM' },
        stationary  = false,
        randomDeath = utils.bind(checkRaceVortex, xi.race.TARU_M),
        allDeath    = utils.bind(checkRaceCrates, xi.race.TARU_M),
    },

    -- Floor 2
    {
        mobs    = { 'Jidra_Boss' },
        mobMods = { [xi.mobMod.DONT_ROAM_HOME] = 1 },
        death   = function(battlefield, mob, count)
            content:openDoor(battlefield, 2)
        end,
    },

    {
        mobs    = { 'Jidra' },
        mobMods = { [xi.mobMod.DONT_ROAM_HOME] = 1 },
        setup   = function(battlefield, mobs)
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
                mob:setPos(position.x, position.y, position.z, position.rot)
            end

            local position = positions[#positions]
            local mob      = GetMobByID(ID.mob.SW_BOSS_JIDRA)
            if mob then
                mob:setPos(position.x, position.y, position.z, position.rot)
            end
        end,

        death = function(battlefield, mob, count)
            local addID = mob:getID() + 7
            local add   = GetMobByID(addID)

            if add then
                add:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                SpawnMob(addID)

                local enmityList = mob:getEnmityList()
                local target     = utils.randomEntry(enmityList)['entity']

                if target ~= nil then
                    add:updateEnmity(target)
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
        death = function(battlefield, mob, count)
            if count == 7 then
                npcUtil.showCrate(GetNPCByID(ID.SW_APOLLYON.npc.ITEM_CRATES[2]))
                npcUtil.showCrate(GetNPCByID(ID.SW_APOLLYON.npc.TIME_CRATES[2]))
                xi.limbus.showRecoverCrate(ID.SW_APOLLYON.npc.RECOVER_CRATES[2])
            end
        end,
    },

    -- Floor 3
    {
        mobs    = { 'Armoury_Crate_Mimic' },
        mobMods =
        {
            [xi.mobMod.NO_MOVE   ] = 1,
            [xi.mobMod.NO_DESPAWN] = 1,
            [xi.mobMod.NO_AGGRO  ] = 1,
        },

        setup = function(battlefield, mobs)
            local shuffled = utils.shuffle(mobs)
            shuffled[1]:setLocalVar('time', 1)
            shuffled[2]:setLocalVar('item', 1)
            shuffled[3]:setLocalVar('recover', 1)
            shuffled[4]:setLocalVar('vortex', 1)

            for _, mob in ipairs(mobs) do
                mob:hideName(true)
                mob:setStatus(xi.status.NORMAL)
                mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
                mob:setMobMod(xi.mobMod.NO_LINK, 1)
                mob:setAnimationSub(0)

                local swapWithCrate = function(crate)
                    crate:setPos(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                    crate:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)
                    crate:setModelId(961)
                    crate:setAnimationSub(8)
                    npcUtil.showCrate(crate)
                    npcUtil.disappearCrate(mob)
                end

                mob:addListener('ON_TRIGGER', 'TRIGGER_RECOVER_CRATE', function(player, npc)
                    if mob:getLocalVar('time') == 1 then
                        swapWithCrate(GetNPCByID(ID.SW_APOLLYON.npc.TIME_CRATES[3]))
                    elseif mob:getLocalVar('item') == 1 then
                        swapWithCrate(GetNPCByID(ID.SW_APOLLYON.npc.ITEM_CRATES[3]))
                    elseif mob:getLocalVar('recover') == 1 then
                        swapWithCrate(GetMobByID(ID.SW_APOLLYON.npc.RECOVER_CRATES[3]))
                    else
                        mob:hideName(false)
                        mob:setStatus(xi.status.UPDATE)
                        mob:setAnimationSub(1)
                        mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
                        mob:updateClaim(player)
                    end
                end)
            end
        end,

        death = function(battlefield, mob)
            if mob:getLocalVar('vortex') == 1 then
                content:openDoor(mob:getBattlefield(), 3)
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
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.ANCIENT_BRASS_INGOT,    weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_DIABOLIC_YARN, weight = xi.loot.weight.NORMAL },
            { item = xi.item.FETID_LANOLIN_CUBE,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.GOLD_STUD,              weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.ARGYRO_RIVET,              weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_LIGHT_FILAMENT,   weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight = xi.loot.weight.LOW       },
        },
    },

    [ID.SW_APOLLYON.npc.ITEM_CRATES[2]] =
    {
        {
            quantity = 5,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SPOOL_OF_LIGHT_FILAMENT, weight = xi.loot.weight.NORMAL },
            { item = xi.item.BLACK_RIVET,             weight = xi.loot.weight.NORMAL },
            { item = xi.item.BLUE_RIVET,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ELECTRUM_STUD,           weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SPOOL_OF_DIABOLIC_YARN,   weight = xi.loot.weight.LOW       },
            { item = xi.item.FETID_LANOLIN_CUBE,       weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_ASTRAL_LEATHER, weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_CANVAS_TOILE,   weight = xi.loot.weight.LOW       },
        },
    },

    [ID.SW_APOLLYON.npc.ITEM_CRATES[3]] =
    {
        {
            quantity = 5,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SQUARE_OF_CARDINAL_CLOTH, weight = xi.loot.weight.NORMAL },
            { item = xi.item.WHITE_RIVET,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_BROWN_DOESKIN,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_CANVAS_TOILE,   weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.ANCIENT_BRASS_INGOT,       weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_BENEDICT_YARN,    weight = xi.loot.weight.LOW       },
            { item = xi.item.POT_OF_EBONY_LACQUER,      weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.NONE,              weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.BLACK_RIVET,       weight = xi.loot.weight.LOW       },
            { item = xi.item.SHEET_OF_KUROGANE, weight = xi.loot.weight.LOW       },
            { item = xi.item.BLUE_RIVET,        weight = xi.loot.weight.LOW       },
            { item = xi.item.GOLD_STUD,         weight = xi.loot.weight.LOW       },
        },

        {
            quantity = 2,
            { item = xi.item.NONE,                    weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.CHUNK_OF_ADAMAN_ORE,     weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.HANDFUL_OF_CLOT_PLASMA,  weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.DARKSTEEL_SHEET,         weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.CHUNK_OF_DARKSTEEL_ORE,  weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.PIECE_OF_OXBLOOD,        weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.LIGHT_STEEL_INGOT,       weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.SPOOL_OF_RAINBOW_THREAD, weight = xi.loot.weight.VERY_LOW  },
            { item = xi.item.PONZE_OF_SHELL_POWDER,   weight = xi.loot.weight.VERY_LOW  },
        },
    },

    [ID.npc.SW_LOOT_CRATE] =
    {
        {
            quantity = 5,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.ARGYRO_RIVET,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_BENEDICT_YARN,    weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_ASTRAL_LEATHER,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_FLAMESHUN_CLOTH, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.SQUARE_OF_CHARCOAL_COTTON, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SHEET_OF_KUROGANE,         weight = xi.loot.weight.NORMAL },
            { item = xi.item.POT_OF_EBONY_LACQUER,      weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_CORDUROY_CLOTH,  weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SQUARE_OF_CARDINAL_CLOTH, weight = xi.loot.weight.LOW       },
            { item = xi.item.WHITE_RIVET,              weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_BROWN_DOESKIN,  weight = xi.loot.weight.LOW       },
            { item = xi.item.ELECTRUM_STUD,            weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.CHARCOAL_CHIP, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.METAL_CHIP, weight = xi.loot.weight.VERY_LOW  },
        },
    },
}

return content:register()
