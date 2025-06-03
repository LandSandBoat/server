-----------------------------------
-- Area: Castle Zvahl Baileys
--  NPC: Switchstix
-- !pos 386.091 -13 -17.399 161
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: Temporary workaround
---@diagnostic disable: param-type-mismatch

local requiredItems = 1
local currencyType = 2
local currencyAmount = 3
local stageNumber = 4
local csParam = 5

local relics =
{
    -- Spharai
    [xi.item.RELIC_KNUCKLES]    =
    {
        {
            xi.item.KOH_I_NOOR,
            xi.item.SQUARE_OF_GRIFFON_LEATHER,
            xi.item.ADAMAN_SHEET
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        4,
        1,
        1
    },
    [xi.item.MILITANT_KNUCKLES] =
    {
        {
            xi.item.BRONZE_KNUCKLES,
            xi.item.METAL_KNUCKLES,
            xi.item.KOENIGS_KNUCKLES
        },
        xi.item.MONTIONT_SILVERPIECE,
        14,
        2,
        2
    },
    [xi.item.DYNAMIS_KNUCKLES]  =
    {
        {
            xi.item.ATTESTATION_OF_MIGHT
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        61,
        3,
        3
    },
    [xi.item.CAESTUS]           =
    {
        {
            xi.item.MYSTIC_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.TEN_THOUSAND_BYNE_BILL,
        1,
        4,
        3
    },

    -- Mandau
    [xi.item.RELIC_DAGGER]      =
    {
        {
            xi.item.BOTTLE_OF_CANTARELLA,
            xi.item.ORICHALCUM_INGOT,
            xi.item.FLASK_OF_DEODORIZER
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        4,
        1,
        1
    },
    [xi.item.MALEFIC_DAGGER]    =
    {
        {
            xi.item.BRASS_DAGGER,
            xi.item.POISON_DAGGER,
            xi.item.MISERICORDE
        },
        xi.item.MONTIONT_SILVERPIECE,
        14,
        2,
        2
    },
    [xi.item.DYNAMIS_DAGGER]    =
    {
        {
            xi.item.ATTESTATION_OF_CELERITY
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        61,
        3,
        3
    },
    [xi.item.BATARDEAU]         =
    {
        {
            xi.item.ORNATE_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.TEN_THOUSAND_BYNE_BILL,
        1,
        4,
        3
    },

    -- Excalibur
    [xi.item.RELIC_SWORD]       =
    {
        {
            xi.item.KOH_I_NOOR,
            xi.item.ORICHALCUM_CHAIN,
            xi.item.CERMET_CHUNK
        },
        xi.item.MONTIONT_SILVERPIECE,
        4,
        1,
        1
    },
    [xi.item.GLYPTIC_SWORD]     =
    {
        {
            xi.item.BRONZE_SWORD,
            xi.item.MYTHRIL_SWORD,
            xi.item.WING_SWORD
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        14,
        2,
        2
    },
    [xi.item.DYNAMIS_SWORD]     =
    {
        {
            xi.item.ATTESTATION_OF_GLORY
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        61,
        3,
        3
    },
    [xi.item.CALIBURN]          =
    {
        {
            xi.item.HOLY_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RANPERRE_GOLDPIECE,
        1,
        4,
        3
    },

    -- Ragnarok
    [xi.item.RELIC_BLADE]       =
    {
        {
            xi.item.SQUARE_OF_GRIFFON_LEATHER,
            xi.item.ADAMAN_INGOT,
            xi.item.PLATINUM_INGOT
        },
        xi.item.MONTIONT_SILVERPIECE,
        4,
        1,
        1
    },
    [xi.item.GILDED_BLADE]      =
    {
        {
            xi.item.CLAYMORE,
            xi.item.MYTHRIL_CLAYMORE,
            xi.item.DARKSTEEL_CLAYMORE
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        16,
        2,
        2
    },
    [xi.item.DYNAMIS_BLADE]     =
    {
        {
            xi.item.ATTESTATION_OF_RIGHTEOUSNESS
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        61,
        3,
        3
    },
    [xi.item.VALHALLA]          =
    {
        {
            xi.item.INTRICATE_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RANPERRE_GOLDPIECE,
        1,
        4,
        3
    },

    -- Guttler
    [xi.item.RELIC_AXE]         =
    {
        {
            xi.item.PIECE_OF_ANGEL_SKIN,
            xi.item.CHRONOS_TOOTH,
            xi.item.FEATHER_COLLAR_P1
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        3,
        1,
        1
    },
    [xi.item.LEONINE_AXE]       =
    {
        {
            xi.item.TABAR,
            xi.item.DARKSTEEL_TABAR,
            xi.item.TABARZIN
        },
        xi.item.MONTIONT_SILVERPIECE,
        14,
        2,
        2
    },
    [xi.item.DYNAMIS_AXE]       =
    {
        {
            xi.item.ATTESTATION_OF_BRAVERY
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        60,
        3,
        3
    },
    [xi.item.OGRE_KILLER]       =
    {
        {
            xi.item.RUNAEIC_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RIMILALA_STRIPESHELL,
        1,
        4,
        3
    },

    -- Bravura
    [xi.item.RELIC_BHUJ]        =
    {
        {
            xi.item.WOOTZ_INGOT,
            xi.item.DAMASCUS_INGOT,
            xi.item.PIECE_OF_ANCIENT_LUMBER
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        3,
        1,
        1
    },
    [xi.item.AGONAL_BHUJ]       =
    {
        {
            xi.item.BUTTERFLY_AXE,
            xi.item.GREATAXE,
            xi.item.HEAVY_DARKSTEEL_AXE
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        16,
        2,
        2
    },
    [xi.item.DYNAMIS_BHUJ]      =
    {
        {
            xi.item.ATTESTATION_OF_FORCE
        },
        xi.item.MONTIONT_SILVERPIECE,
        60,
        3,
        3
    },
    [xi.item.ABADDON_KILLER]    =
    {
        {
            xi.item.SERAPHIC_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.TEN_THOUSAND_BYNE_BILL,
        1,
        4,
        3
    },

    -- Gungnir
    [xi.item.RELIC_LANCE]       =
    {
        {
            xi.item.PIECE_OF_LANCEWOOD_LUMBER,
            xi.item.ORICHALCUM_INGOT,
            xi.item.SPOOL_OF_ARACHNE_THREAD
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        4,
        1,
        1
    },
    [xi.item.HOTSPUR_LANCE]     =
    {
        {
            xi.item.BRASS_SPEAR,
            xi.item.HALBERD,
            xi.item.WYVERN_SPEAR
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        16,
        2,
        2
    },
    [xi.item.DYNAMIS_LANCE]     =
    {
        {
            xi.item.ATTESTATION_OF_FORTITUDE
        },
        xi.item.MONTIONT_SILVERPIECE,
        61,
        3,
        3
    },
    [xi.item.GAE_ASSAIL]        =
    {
        {
            xi.item.STELLAR_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RIMILALA_STRIPESHELL,
        1,
        4,
        3
    },

    -- Apocalypse
    [xi.item.RELIC_SCYTHE]      =
    {
        {
            xi.item.MAMMOTH_TUSK,
            xi.item.SQUARE_OF_MANTICORE_LEATHER,
            xi.item.RAINBOW_OBI
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        5,
        1,
        1
    },
    [xi.item.MEMENTO_SCYTHE]    =
    {
        {
            xi.item.SCYTHE,
            xi.item.BONE_SCYTHE,
            xi.item.DEATH_SCYTHE
        },
        xi.item.MONTIONT_SILVERPIECE,
        16,
        2,
        2
    },
    [xi.item.DYNAMIS_SCYTHE]    =
    {
        {
            xi.item.ATTESTATION_OF_VIGOR
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        62,
        3,
        3
    },
    [xi.item.BEC_DE_FAUCON]     =
    {
        {
            xi.item.TENEBROUS_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RIMILALA_STRIPESHELL,
        1,
        4,
        3
    },

    -- Kikoku
    [xi.item.IHINTANTO]         =
    {
        {
            xi.item.CHUNK_OF_RELIC_STEEL,
            xi.item.TARASQUE_SKIN,
            xi.item.SPOOL_OF_TWINTHREAD
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        4,
        1,
        1
    },
    [xi.item.MIMIZUKU]          =
    {
        {
            xi.item.WAKIZASHI,
            xi.item.KABUTOWARI,
            xi.item.SAKURAFUBUKI
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        16,
        2,
        2
    },
    [xi.item.ROGETSU]           =
    {
        {
            xi.item.ATTESTATION_OF_LEGERITY
        },
        xi.item.MONTIONT_SILVERPIECE,
        61,
        3,
        3
    },
    [xi.item.YOSHIMITSU]        =
    {
        {
            xi.item.DEMONIAC_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.TEN_THOUSAND_BYNE_BILL,
        1,
        4,
        3
    },

    -- Amanomurakumo
    [xi.item.ITO]               =
    {
        {
            xi.item.CHUNK_OF_RELIC_STEEL,
            xi.item.SPOOL_OF_SIRENS_MACRAME,
            xi.item.LUMP_OF_TAMA_HAGANE
        },
        xi.item.MONTIONT_SILVERPIECE,
        3,
        1,
        1
    },
    [xi.item.HAYATEMARU]        =
    {
        {
            xi.item.TACHI,
            xi.item.MIKAZUKI,
            xi.item.KAZARIDACHI
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        15,
        2,
        2
    },
    [xi.item.OBOROMARU]         =
    {
        {
            xi.item.ATTESTATION_OF_DECISIVENESS
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        60,
        3,
        3
    },
    [xi.item.TOTSUKANOTSURUGI]  =
    {
        {
            xi.item.DIVINE_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RANPERRE_GOLDPIECE,
        1,
        4,
        3
    },

    -- Mjollnir
    [xi.item.RELIC_MAUL]        =
    {
        {
            xi.item.WOOTZ_INGOT,
            xi.item.PLATINUM_INGOT,
            xi.item.SQUARE_OF_RAINBOW_CLOTH
        },
        xi.item.MONTIONT_SILVERPIECE,
        5,
        1,
        1
    },
    [xi.item.BATTERING_MAUL]    =
    {
        {
            xi.item.WARHAMMER,
            xi.item.HOLY_MAUL,
            xi.item.BRASS_HAMMER
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        16,
        2,
        2
    },
    [xi.item.DYNAMIS_MAUL]      =
    {
        {
            xi.item.ATTESTATION_OF_SACRIFICE
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        62,
        3,
        3
    },
    [xi.item.GULLINTANI]        =
    {
        {
            xi.item.HEAVENLY_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RANPERRE_GOLDPIECE,
        1,
        4,
        3
    },

    -- Claustrum
    [xi.item.RELIC_STAFF]       =
    {
        {
            xi.item.PIECE_OF_LANCEWOOD_LUMBER,
            xi.item.PIGEONS_BLOOD_RUBY,
            xi.item.POT_OF_URUSHI
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        5,
        1,
        1
    },
    [xi.item.SAGES_STAFF]       =
    {
        {
            xi.item.ASH_STAFF,
            xi.item.ELM_STAFF,
            xi.item.MAHOGANY_STAFF
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        16,
        2,
        2
    },
    [xi.item.DYNAMIS_STAFF]     =
    {
        {
            xi.item.ATTESTATION_OF_VIRTUE
        },
        xi.item.MONTIONT_SILVERPIECE,
        62,
        3,
        3
    },
    [xi.item.THYRUS]            =
    {
        {
            xi.item.CELESTIAL_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RIMILALA_STRIPESHELL,
        1,
        4,
        3
    },

    -- Annihilator
    [xi.item.RELIC_GUN]         =
    {
        {
            xi.item.FLASK_OF_MARKSMANS_OIL,
            xi.item.SQUARE_OF_RAINBOW_CLOTH,
            xi.item.DARKSTEEL_INGOT
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        5,
        1,
        1
    },
    [xi.item.MARKSMANS_GUN]     =
    {
        {
            xi.item.ARQUEBUS,
            xi.item.HELLFIRE,
            xi.item.PIRATES_GUN
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        15,
        2,
        2
    },
    [xi.item.DYNAMIS_GUN]       =
    {
        {
            xi.item.ATTESTATION_OF_ACCURACY
        },
        xi.item.MONTIONT_SILVERPIECE,
        62,
        3,
        3
    },
    [xi.item.FERDINAND]         =
    {
        {
            xi.item.ETHEREAL_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.TEN_THOUSAND_BYNE_BILL,
        1,
        4,
        3
    },

    -- Gjallarhorn
    [xi.item.RELIC_HORN]        =
    {
        {
            xi.item.MAMMOTH_TUSK,
            xi.item.CHRONOS_TOOTH,
            xi.item.SWORDBELT_P1
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        3,
        1,
        1
    },
    [xi.item.PYRRHIC_HORN]      =
    {
        {
            xi.item.HORN,
            xi.item.GEMSHORN,
            xi.item.SHOFAR
        },
        xi.item.ONE_HUNDRED_BYNE_BILL,
        14,
        2,
        2
    },
    [xi.item.DYNAMIS_HORN]      =
    {
        {
            xi.item.ATTESTATION_OF_HARMONY
        },
        xi.item.MONTIONT_SILVERPIECE,
        60,
        3,
        3
    },
    [xi.item.MILLENNIUM_HORN]   =
    {
        {
            xi.item.MYSTERIAL_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RIMILALA_STRIPESHELL,
        1,
        4,
        3
    },

    -- Yoichinoyumi
    [xi.item.RELIC_BOW]         =
    {
        {
            xi.item.BEHEMOTH_HORN,
            xi.item.PIECE_OF_LANCEWOOD_LUMBER,
            xi.item.LOOP_OF_CARBON_FIBER
        },
        xi.item.MONTIONT_SILVERPIECE,
        4,
        1,
        1
    },
    [xi.item.WOLVER_BOW]        =
    {
        {
            xi.item.POWER_BOW,
            xi.item.WAR_BOW,
            xi.item.SHIGETO_BOW
        },
        xi.item.MONTIONT_SILVERPIECE,
        15,
        2,
        2
    },
    [xi.item.DYNAMIS_BOW]       =
    {
        {
            xi.item.ATTESTATION_OF_TRANSCENDENCE
        },
        xi.item.LUNGO_NANGO_JADESHELL,
        61,
        3,
        3
    },
    [xi.item.FUTATOKOROTO]      =
    {
        {
            xi.item.SNARLED_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RANPERRE_GOLDPIECE,
        1,
        4,
        3
    },

    -- Aegis
    [xi.item.RELIC_SHIELD]      =
    {
        {
            xi.item.SQUARE_OF_AMALTHEIA_LEATHER,
            xi.item.ORICHALCUM_SHEET,
            xi.item.PIECE_OF_ANCIENT_LUMBER
        },
        0,
        1,
        1,
        4
    },
    [xi.item.BULWARK_SHIELD]    =
    {
        {
            xi.item.BUCKLER,
            xi.item.ROUND_SHIELD,
            xi.item.KOENIG_SHIELD
        },
        0,
        4,
        2,
        5
    },
    [xi.item.DYNAMIS_SHIELD]    =
    {
        {
            xi.item.ATTESTATION_OF_INVULNERABILITY
        },
        0,
        20,
        3,
        6
    },
    [xi.item.ANCILE]            =
    {
        {
            xi.item.SUPERNAL_FRAGMENT,
            xi.item.SHARD_OF_NECROPSYCHE
        },
        xi.item.RANPERRE_GOLDPIECE,
        1,
        4,
        6
    }
}

local function hasRelic(player, isTrade)
    if isTrade then
        for key, value in pairs(relics) do
            if player:hasItemQty(key, 1) then
                return key
            end
        end

        return nil
    else
        for key, value in pairs(relics) do
            if player:hasItem(key, xi.inv.INVENTORY) then
                return key
            end
        end

        return nil
    end
end

local function tradeHasRequiredCurrency(trade, currentRelic)
    local relic = relics[currentRelic]

    -- Aegis multi-currency trades
    if
        currentRelic == xi.item.RELIC_SHIELD or
        currentRelic == xi.item.BULWARK_SHIELD or
        currentRelic == xi.item.DYNAMIS_SHIELD
    then
        if currentRelic == xi.item.RELIC_SHIELD and trade:getItemCount() == 3 then
            return trade:hasItemQty(xi.item.ONE_HUNDRED_BYNE_BILL, 1) and
                trade:hasItemQty(xi.item.MONTIONT_SILVERPIECE, 1) and
                trade:hasItemQty(xi.item.LUNGO_NANGO_JADESHELL, 1)
        elseif currentRelic == xi.item.BULWARK_SHIELD and trade:getItemCount() == 12 then
            return trade:hasItemQty(xi.item.ONE_HUNDRED_BYNE_BILL, 4) and
                trade:hasItemQty(xi.item.MONTIONT_SILVERPIECE, 4) and
                trade:hasItemQty(xi.item.LUNGO_NANGO_JADESHELL, 4)
        elseif currentRelic == xi.item.DYNAMIS_SHIELD and trade:getItemCount() == 60 then
            return trade:hasItemQty(xi.item.ONE_HUNDRED_BYNE_BILL, 20) and
                trade:hasItemQty(xi.item.MONTIONT_SILVERPIECE, 20) and
                trade:hasItemQty(xi.item.LUNGO_NANGO_JADESHELL, 20)
        else
            return false
        end
    else
        if trade:getItemCount() ~= relic[currencyAmount] then
            return false
        else
            return trade:hasItemQty(relic[currencyType], relic[currencyAmount])
        end
    end
end

local function tradeHasRequiredMaterials(trade, relicId, reqItems)
    if trade:getItemCount() ~= (#reqItems + 1) then
        return false
    else
        if not trade:hasItemQty(relicId, 1) then
            return false
        end

        for i = 1, #reqItems, 1 do
            if not trade:hasItemQty(reqItems[i], 1) then
                return false
            end
        end

        return true
    end
end

entity.onTrade = function(player, npc, trade)
    local relicId = hasRelic(trade, true)
    local currentRelic = player:getCharVar('RELIC_IN_PROGRESS')
    local gil = trade:getGil()

    if gil ~= 0 then
        return
    elseif relicId ~= nil then
        local relic = relics[relicId]
        local relicDupe = player:getCharVar('RELIC_MAKE_ANOTHER')

        if player:hasItem(relicId + 1) and relicDupe ~= 1 then
            player:startEvent(20, relicId)
        elseif currentRelic == 0 then
            if
                relic[stageNumber] ~= 4 and
                tradeHasRequiredMaterials(trade, relicId, relic[requiredItems])
            then
                local requiredItem1 = relic[requiredItems][1] ~= nil and relic[requiredItems][1] or 0
                local requiredItem2 = relic[requiredItems][2] ~= nil and relic[requiredItems][2] or 0
                local requiredItem3 = relic[requiredItems][3] ~= nil and relic[requiredItems][3] or 0
                player:setCharVar('RELIC_IN_PROGRESS', relicId)
                player:tradeComplete()
                player:startEvent(11, relicId, requiredItem1, requiredItem2, requiredItem3, relic[currencyType], relic[currencyAmount], 0, relic[csParam])
            end
        elseif currentRelic ~= 0 and relicId ~= currentRelic then
            player:startEvent(87)
        end
    elseif currentRelic ~= 0 then
        local relic = relics[currentRelic]
        local currentStage = relic[stageNumber]

        if currentStage ~= 4 and tradeHasRequiredCurrency(trade, currentRelic) then
            if currentStage == 1 then
                player:setCharVar('RELIC_DUE_AT', getVanaMidnight())
            elseif currentStage == 2 then
                player:setCharVar('RELIC_DUE_AT', os.time() + xi.settings.main.RELIC_2ND_UPGRADE_WAIT_TIME)
            elseif currentStage == 3 then
                player:setCharVar('RELIC_DUE_AT', os.time() + xi.settings.main.RELIC_3RD_UPGRADE_WAIT_TIME)
            end

            player:tradeComplete()
            player:startEvent(13, currentRelic, relic[currencyType], relic[currencyAmount], 0, 0, 0, 0, relic[csParam])
        end
    end
end

entity.onTrigger = function(player, npc)
    local relicId = hasRelic(player, false)
    local currentRelic = player:getCharVar('RELIC_IN_PROGRESS')
    local relicWait = player:getCharVar('RELIC_DUE_AT')
    local relicConquest = player:getCharVar('RELIC_CONQUEST_WAIT')

    if
        currentRelic ~= 0 and
        relicWait ~= 0 and
        relics[currentRelic][stageNumber] ~= 4
    then
        local relic = relics[currentRelic]
        local currentStage = relic[stageNumber]

        if relicWait > os.time() then
            -- Not enough time has passed
            if currentStage == 1 then
                player:startEvent(15, 0, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 2 then
                player:startEvent(18, 0, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 3 then
                player:startEvent(51, 0, 0, 0, 0, 0, 0, 0, relic[csParam])
            end
        elseif relicWait <= os.time() then
            -- Enough time has passed
            if currentStage == 1 then
                player:startEvent(16, currentRelic, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 2 then
                player:startEvent(19, currentRelic, 0, 0, 0, 0, 0, 0, relic[csParam])
            elseif currentStage == 3 then
                player:startEvent(52, currentRelic, 0, 0, 0, 0, 0, 0, relic[csParam])
            end
        end
    elseif
        currentRelic ~= 0 and
        relicWait == 0 and
        relics[currentRelic][stageNumber] ~= 4
    then
        -- Need currency to start timer
        local relic = relics[currentRelic]
        player:startEvent(12, currentRelic, relic[currencyType], relic[currencyAmount], 0, 0, 0, 0, relic[csParam])
    elseif relicId == nil or relicConquest > os.time() then
        -- Player doesn't have a relevant item and hasn't started one
        player:startEvent(10)
    elseif relicId ~= nil and relicConquest <= os.time() then
        -- Player has a relevant item and conquest tally has passed
        local relic = relics[relicId]
        local currentStage = relic[stageNumber]
        local requiredItem1 = relic[requiredItems][1] ~= nil and relic[requiredItems][1] or 0
        local requiredItem2 = relic[requiredItems][2] ~= nil and relic[requiredItems][2] or 0
        local requiredItem3 = relic[requiredItems][3] ~= nil and relic[requiredItems][3] or 0

        if currentStage == 1 then
            player:startEvent(14, relicId, requiredItem1, requiredItem2, requiredItem3, 0, 0, 0, relic[csParam])
        elseif currentStage == 2 then
            player:startEvent(17, relicId, requiredItem1, requiredItem2, requiredItem3, 0, 0, 0, relic[csParam])
        elseif currentStage == 3 then
            player:startEvent(50, relicId, requiredItem1, requiredItem2, requiredItem3, 0, 0, 0, relic[csParam])
        elseif currentStage == 4 then
            local itemToEventId =
            {
                [xi.item.CAESTUS]          = 68, -- Spharai
                [xi.item.BATARDEAU]        = 69, -- Mandau
                [xi.item.CALIBURN]         = 70, -- Excalibur
                [xi.item.VALHALLA]         = 71, -- Ragnarok
                [xi.item.OGRE_KILLER]      = 72, -- Guttler
                [xi.item.ABADDON_KILLER]   = 73, -- Bravura
                [xi.item.GAE_ASSAIL]       = 75, -- Gungnir
                [xi.item.BEC_DE_FAUCON]    = 74, -- Apocalypse
                [xi.item.YOSHIMITSU]       = 76, -- Kikoku
                [xi.item.TOTSUKANOTSURUGI] = 77, -- Amanomurakumo
                [xi.item.GULLINTANI]       = 78, -- Mjollnir
                [xi.item.THYRUS]           = 79, -- Claustrum
                [xi.item.FERDINAND]        = 81, -- Annihilator
                [xi.item.MILLENNIUM_HORN]  = 82, -- Gjallarhorn
                [xi.item.FUTATOKOROTO]     = 80, -- Yoichinoyumi
                [xi.item.ANCILE]           = 86, -- Aegis
            }

            player:startEvent(itemToEventId[relicId], requiredItem1, requiredItem2, relic[currencyType], relic[currencyAmount], relicId)
        end
    else
        player:startEvent(10)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    -- Handles the displayed currency types and amounts for Aegis Stage 1->2, 2->3, and 3->4 based on option.
    if (csid == 11 or csid == 12 or csid == 13) and option ~= 0 then
        if option == 1 then
            player:updateEvent(xi.item.RELIC_SHIELD,
                xi.item.MONTIONT_SILVERPIECE, 1,
                xi.item.ONE_HUNDRED_BYNE_BILL, 1,
                xi.item.LUNGO_NANGO_JADESHELL, 1)
        elseif option == 2 then
            player:updateEvent(xi.item.BULWARK_SHIELD,
                xi.item.MONTIONT_SILVERPIECE, 4,
                xi.item.ONE_HUNDRED_BYNE_BILL, 4,
                xi.item.LUNGO_NANGO_JADESHELL, 4)
        elseif option == 3 then
            player:updateEvent(xi.item.DYNAMIS_SHIELD,
                xi.item.MONTIONT_SILVERPIECE, 20,
                xi.item.ONE_HUNDRED_BYNE_BILL, 20,
                xi.item.LUNGO_NANGO_JADESHELL, 20)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local reward = player:getCharVar('RELIC_IN_PROGRESS')

    -- User is cancelling a relic.  Null everything out, it never happened.
    if csid == 87 and option == 666 then
        player:setCharVar('RELIC_IN_PROGRESS', 0)
        player:setCharVar('RELIC_DUE_AT', 0)
        player:setCharVar('RELIC_MAKE_ANOTHER', 0)
        player:setCharVar('RELIC_CONQUEST_WAIT', 0)

        -- User is okay with making a relic they cannot possibly accept
    elseif csid == 20 and option == 1 then
        player:setCharVar('RELIC_MAKE_ANOTHER', 1)

        -- Picking up a finished relic stage 1>2 and 2>3.
    elseif (csid == 16 or csid == 19) and reward ~= 0 then
        if player:getFreeSlotsCount() < 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward + 1)
        else
            player:addItem(reward + 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward + 1)
            player:setCharVar('RELIC_IN_PROGRESS', 0)
            player:setCharVar('RELIC_DUE_AT', 0)
            player:setCharVar('RELIC_MAKE_ANOTHER', 0)
            player:setCharVar('RELIC_CONQUEST_WAIT', NextConquestTally())
        end

        -- Picking up a finished relic stage 3>4.
    elseif csid == 52 and reward ~= 0 then
        if player:getFreeSlotsCount() < 1 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward + 1)
        else
            player:addItem(reward + 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, reward + 1)
            player:setCharVar('RELIC_IN_PROGRESS', 0)
            player:setCharVar('RELIC_DUE_AT', 0)
            player:setCharVar('RELIC_MAKE_ANOTHER', 0)
            player:setCharVar('RELIC_CONQUEST_WAIT', 0)
        end

        -- Stage 4 cutscenes
    elseif (csid >= 68 and csid <= 82) or csid == 86 then
        local eventToItemId =
        {
            [68] = xi.item.CAESTUS,          -- Spharai
            [69] = xi.item.BATARDEAU,        -- Mandau
            [70] = xi.item.CALIBURN,         -- Excalibur
            [71] = xi.item.VALHALLA,         -- Ragnarok
            [72] = xi.item.OGRE_KILLER,      -- Guttler
            [73] = xi.item.ABADDON_KILLER,   -- Bravura
            [75] = xi.item.GAE_ASSAIL,       -- Gungnir
            [74] = xi.item.BEC_DE_FAUCON,    -- Apocalypse
            [76] = xi.item.YOSHIMITSU,       -- Kikoku
            [77] = xi.item.TOTSUKANOTSURUGI, -- Amanomurakumo
            [78] = xi.item.GULLINTANI,       -- Mjollnir
            [79] = xi.item.THYRUS,           -- Claustrum
            [81] = xi.item.FERDINAND,        -- Annihilator
            [82] = xi.item.MILLENNIUM_HORN,  -- Gjallarhorn
            [80] = xi.item.FUTATOKOROTO,     -- Yoichinoyumi
            [86] = xi.item.ANCILE,           -- Aegis
        }

        player:setCharVar('RELIC_CONQUEST_WAIT', 0)
        player:setCharVar('RELIC_IN_PROGRESS', eventToItemId[csid])
    end
end

return entity

-- TODO: Temporary workaround
---@diagnostic enable: param-type-mismatch
