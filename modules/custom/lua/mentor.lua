-----------------------------------
-- Moogle Buffs
-----------------------------------

xi = xi or {}
xi.mentor = xi.mentor or {}

-----------------------------------
-- Field Moogle Buffs
-----------------------------------
xi.mentor.clickMoogle = function(player, npc)
    local plevel = player:getMainLvl()
    local zoneid = player:getZoneID()

    local protect = 0
    local shell = 0
    local regenfresh = 0

    local lvlduration = 3600 -- Non Mentor: Level 1-70 get 60min buff durations
    local mentorduration = 3600 -- Mentor: Level 1-75 get 60min buff durations

    -- Check the players level and change the strength of Regen/Refresh accordingly
    if plevel >= 1 and plevel <= 20 then
        regenfresh = 1
    elseif plevel >= 21 and plevel <= 40 then
        regenfresh = 2
    else
        regenfresh = 2
    end

    -- Check the players level and change the strength of Protect accordingly
    if plevel >= 1 and plevel <= 26 then
        protect = 15 -- Protect I
    elseif plevel >= 27 and plevel <= 46 then
        protect = 40 -- Protect II
    elseif plevel >= 47 and plevel <= 62 then
        protect = 75 -- Protect III
    else
        protect = 120 -- Protect IV
    end

    -- Check the players level and change the strength of Shell accordingly
    if plevel >= 1 and plevel <= 36 then
        shell = 9 -- Shell I
    elseif plevel >= 37 and plevel <= 56 then
        shell = 14 -- Shell II
    elseif plevel >= 57 and plevel <= 68 then
        shell = 19 -- Shell III
    else
        shell = 22 -- Shell IV
    end

    local zones =
    {
        [xi.zone.VALKURM_DUNES]             = { low = 9, high = 23 },
        [xi.zone.KORROLOKA_TUNNEL]          = { low = 9, high = 23 },
        [xi.zone.QUFIM_ISLAND]              = { low = 18, high = 33 },
        [xi.zone.YUHTUNGA_JUNGLE]           = { low = 18, high = 35 },
        [xi.zone.ROLANBERRY_FIELDS_S]       = { low = 19, high = 32 },
        [xi.zone.SAUROMUGUE_CHAMPAIGN]      = { low = 20, high = 33 },
        [xi.zone.NORTH_GUSTABERG_S]         = { low = 24, high = 27 },
        [xi.zone.YHOATOR_JUNGLE]            = { low = 26, high = 40 },
        [xi.zone.BIBIKI_BAY]                = { low = 26, high = 74 },
        [xi.zone.WEST_SARUTABARUTA_S]       = { low = 28, high = 31 },
        [xi.zone.VUNKERL_INLET_S]           = { low = 28, high = 35 },
        [xi.zone.CRAWLERS_NEST]             = { low = 28, high = 55 },
        [xi.zone.GARLAIGE_CITADEL]          = { low = 28, high = 55 },
        [xi.zone.THE_SANCTUARY_OF_ZITAH]    = { low = 28, high = 45 },
        [xi.zone.EAST_RONFAURE_S]           = { low = 30, high = 46 },
        [xi.zone.GUSTAV_TUNNEL]             = { low = 36, high = 48 },
        [xi.zone.QUICKSAND_CAVES]           = { low = 40, high = 65 },
        [xi.zone.WESTERN_ALTEPA_DESERT]     = { low = 41, high = 50 },
        [xi.zone.WAJAOM_WOODLANDS]          = { low = 48, high = 60 },
        [xi.zone.KUFTAL_TUNNEL]             = { low = 48, high = 60 },
        [xi.zone.THE_BOYAHDA_TREE]          = { low = 48, high = 72 },
        [xi.zone.AYDEEWA_SUBTERRANE]        = { low = 58, high = 66 },
        [xi.zone.BHAFLAU_THICKETS]          = { low = 58, high = 68 },
        [xi.zone.CAEDARVA_MIRE]             = { low = 63, high = 74 },
        [xi.zone.BEAUCEDINE_GLACIER_S]      = { low = 64, high = 72 },
    }

    local area = zones[zoneid]
    if plevel >= area.low and plevel <= area.high then
        if player:getCharVar('MentorFlag') == 0 then
            player:addStatusEffect(xi.effect.PROTECT, protect, 0, lvlduration)
            player:addStatusEffect(xi.effect.SHELL, shell, 0, lvlduration)
            player:addStatusEffect(xi.effect.REGEN, regenfresh, 3, lvlduration)
            player:addStatusEffect(xi.effect.REFRESH, regenfresh, 3, lvlduration)
            player:addStatusEffect(xi.effect.RERAISE, 1, 0, lvlduration)
            player:setCharVar('MoogleBuffs', 1)
            player:printToPlayer('Enjoy your 60min Non-Mentor buffs, they\'re removed when you zone.', xi.msg.channel.SAY, 'Moogle')
        else
            player:addStatusEffect(xi.effect.PROTECT, protect, 0, mentorduration)
            player:addStatusEffect(xi.effect.SHELL, shell, 0, mentorduration)
            player:addStatusEffect(xi.effect.REGEN, regenfresh, 3, mentorduration)
            player:addStatusEffect(xi.effect.REFRESH, regenfresh, 3, mentorduration)
            player:addStatusEffect(xi.effect.RERAISE, 1, 0, mentorduration)
            player:addStatusEffect(xi.effect.STR_BOOST, 10, 0, mentorduration) -- Mentor Only
            player:addStatusEffect(xi.effect.HASTE, 1000, 0, mentorduration) -- Mentor Only
            player:setCharVar('MoogleBuffs', 1)
            player:printToPlayer('Enjoy your 60min Mentor buffs, they\'re removed when you zone.', xi.msg.channel.SAY, 'Moogle')
        end
    else
        player:printToPlayer('Your level isn\'t right for my mighty Moogle magic. Maybe try another camp?', xi.msg.channel.SAY, 'Moogle')
    end
end

-----------------------------------
-- Merit Moogle Buffs
-----------------------------------
xi.mentor.meritMoogle = function(player, npc)
    local party = player:getParty()
    local gen = 0
    local balladJobs = { [xi.job.BLM] = true, [xi.job.SMN] = true, [xi.job.SCH] = true, [xi.job.BLU] = true }

    if player:getPartySize() == 3 then
        gen = 3
    elseif player:getPartySize() == 4 then
        gen = 2
    elseif player:getPartySize() >= 5 then
        gen = 1
    end

    for _, v in ipairs(party) do
        if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
            if v:checkDistance(player) > 50 then
                v:printToPlayer('You are too far away from your Leader.', xi.msg.channel.SAY, 'Merit Moogle')
                return
            end
        end
    end

    for _, v in ipairs(party) do
        if v:getZoneID() == player:getZoneID() then
            v:delStatusEffectsByFlag(xi.effectFlag.DISPELABLE)
            v:printToPlayer('Welcome to the Era Merit Moogle', xi.msg.channel.SAY, 'Merit Moogle')
            v:setCharVar('MoogleBuffs', 1)
            v:addStatusEffect(xi.effect.RERAISE, 1, 0, 3600)
            v:addStatusEffect(xi.effect.PROTECT, 120, 0, 3600)
            v:addStatusEffect(xi.effect.SHELL, 22, 0, 3600)
            v:addStatusEffect(xi.effect.REGEN, gen, 0, 3600)
            v:addStatusEffect(xi.effect.REFRESH, 3, 0, 3600)

            if balladJobs[v:getMainJob()] then
                v:addStatusEffect(xi.effect.BALLAD, 2, 0, 3600)
            end
        end
    end
end

xi.mentor.meritMoogleMentor = function(player, npc)
    local party = player:getAlliance()
    local gen = 0

    if #party == 3 then
        gen = 3
    elseif #party == 4 then
        gen = 2
    elseif #party >= 5 then
        gen = 1
    end

    for _, v in ipairs(party) do
        if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
            if v:checkDistance(player) > 50 then
                v:printToPlayer('You are too far away from your Mentor.', xi.msg.channel.SAY, 'Merit Moogle')
                return
            end
        end
    end

    for _, v in ipairs(party) do
        if v:getZoneID() == player:getZoneID() then
            v:delStatusEffectsByFlag(xi.effectFlag.DISPELABLE)
            v:printToPlayer('Welcome to the Era Merit Moogle, Bonus Mentor Buffs!', xi.msg.channel.SAY, 'Merit Moogle')
            v:setCharVar('MoogleBuffs', 1)
            v:addStatusEffect(xi.effect.RERAISE, 2, 0, 3600)
            v:addStatusEffect(xi.effect.PROTECT, 120, 0, 3600)
            v:addStatusEffect(xi.effect.SHELL, 22, 0, 3600)
            v:addStatusEffect(xi.effect.REGEN, gen, 0, 3600)

            if v:getMainJob() == xi.job.BLM or v:getMainJob() == xi.job.SMN then
                v:addStatusEffect(xi.effect.BALLAD, 3, 0, 3600)
            elseif v:getMainJob() == xi.job.SAM or v:getMainJob() == xi.job.DRG then
                v:addStatusEffect(xi.effect.REGAIN, (gen * 2), 0, 3600)
            elseif v:getMainJob() == xi.job.WHM or v:getMainJob() == xi.job.SCH then
                v:addStatusEffect(xi.effect.MND_BOOST, 10, 0, 3600)
                v:addStatusEffect(xi.effect.MAX_MP_BOOST, 100, 0, 0)
            elseif v:getMainJob() == xi.job.PLD or v:getMainJob() == xi.job.NIN then
                v:addStatusEffect(xi.effect.PHALANX, (gen) * 10, 0, 3600)
                v:addStatusEffect(xi.effect.MAX_HP_BOOST, 100, 0, 0)
            elseif v:getMainJob() == xi.job.PUP or v:getMainJob() == xi.job.BST then
                v:addStatusEffect(xi.effect.ACCURACY_BOOST, 15, 0, 3600)
            end
        end
    end
end

-----------------------------------
-- Merit Moogle Sigil Purchase
-----------------------------------
xi.mentor.meritMoogleSigil = function(player, npc, trade)
    local alliedNotes = player:getCurrency('allied_notes')
    local gil4k = npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 4000 } })
    local gil3k = npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 3000 } })
    local gil2k = npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 2000 } })
    local gil1k = npcUtil.tradeHasExactly(trade, { { xi.item.GIL, 1000 } })

    if alliedNotes >= 150 and gil4k then
        player:confirmTrade()
        player:delStatusEffect(xi.effect.SIGIL)
        player:delStatusEffect(xi.effect.SANCTION)
        player:delStatusEffect(xi.effect.SIGNET)
        player:addStatusEffect(xi.effect.SIGIL, 3, 0, 3600, 0, 35, 0) -- both
        player:delCurrency('allied_notes', 150)
    elseif alliedNotes >= 100 and gil3k then
        player:confirmTrade()
        player:delStatusEffect(xi.effect.SIGIL)
        player:delStatusEffect(xi.effect.SANCTION)
        player:delStatusEffect(xi.effect.SIGNET)
        player:addStatusEffect(xi.effect.SIGIL, 2, 0, 3600, 0, 35, 0) -- refresh
        player:delCurrency('allied_notes', 100)
    elseif gil2k then
        player:confirmTrade()
        player:delStatusEffect(xi.effect.SIGIL)
        player:delStatusEffect(xi.effect.SANCTION)
        player:delStatusEffect(xi.effect.SIGNET)
        player:addStatusEffect(xi.effect.SIGIL, 1, 0, 3600, 0, 35, 0) -- regen
    elseif alliedNotes >= 50 and gil1k then
        player:confirmTrade()
        player:delStatusEffect(xi.effect.SIGIL)
        player:delStatusEffect(xi.effect.SANCTION)
        player:delStatusEffect(xi.effect.SIGNET)
        player:addStatusEffect(xi.effect.SIGIL, 0, 0, 3600, 0, 35, 0)
        player:delCurrency('allied_notes', 50)
    end
end

-----------------------------------
-- Moogle Mentor Shops
-----------------------------------
xi.mentor.openShop = function(player, npc)
    if player:getVar('MentorFlag') ~= 1 then
        return
    end

    local plevel = player:getMainLvl()
    local zoneId = player:getZoneID()

    local zones8  = { xi.zone.VALKURM_DUNES, xi.zone.KORROLOKA_TUNNEL }
    local zones18 = { xi.zone.YUHTUNGA_JUNGLE, xi.zone.YHOATOR_JUNGLE, xi.zone.QUFIM_ISLAND, xi.zone.ROLANBERRY_FIELDS_S, xi.zone.SAUROMUGUE_CHAMPAIGN }
    local zones28 = { xi.zone.EAST_RONFAURE_S, xi.zone.CRAWLERS_NEST, xi.zone.THE_SANCTUARY_OF_ZITAH, xi.zone.GARLAIGE_CITADEL }
    local zones38 = { xi.zone.KUFTAL_TUNNEL, xi.zone.WESTERN_ALTEPA_DESERT, xi.zone.QUICKSAND_CAVES, xi.zone.GUSTAV_TUNNEL }
    local zones48 = { xi.zone.WAJAOM_WOODLANDS, xi.zone.THE_BOYAHDA_TREE }
    local zones58 = { xi.zone.AYDEEWA_SUBTERRANE, xi.zone.BHAFLAU_THICKETS }
    local zones65 = { xi.zone.CAEDARVA_MIRE, xi.zone.BIBIKI_BAY }

    local function inZones(zones)
        for _, z in ipairs(zones) do
            if zoneId == z then
                return true
            end
        end

        return false
    end

    if inZones(zones8) and plevel >= 8 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.ENTRANCING_RIBBON,   10000 },
            { xi.item.GELONG_STAFF,        10000 },
            { xi.item.KATAYAMA_ICHIMONJI,  10000 },
            { xi.item.PIKE,                10000 },
            { xi.item.PILGRIMS_WAND,       10000 },
            { xi.item.ROYAL_ARCHERS_SWORD, 10000 },
            { xi.item.GUST_CLAYMORE,       10000 },
            { xi.item.LEGIONNAIRES_SCYTHE, 10000 },
            { xi.item.CLIPEUS,             10000 },
            { xi.item.HYDRO_BAGHNAKHS,     10000 },
            { xi.item.GASSAN,              10000 },
            { xi.item.FELLING_AXE,         10000 },
            { xi.item.HYDRO_AXE,           10000 },
            { xi.item.KNIFE,               10000 },
            { xi.item.DART,                9 },
            { xi.item.IRON_ARROW,          7 },
            { xi.item.CROSSBOW_BOLT,       5 },
            { xi.item.WOODEN_ARROW,        3 },
        })
    elseif inZones(zones18) and plevel >= 18 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.WURGER,                20000 },
            { xi.item.MERCENARYS_GREATSWORD, 20000 },
            { xi.item.MAMMUT,                20000 },
            { xi.item.CRUEL_SPEAR,           20000 },
            { xi.item.CRUEL_SCYTHE,          20000 },
            { xi.item.BURNITE_SHELL_STONE,   20000 },
            { xi.item.AURIGA_XIPHOS,         20000 },
            { xi.item.ALMOGAVAR_BOW,         20000 },
            { xi.item.NADRS,                 20000 },
            { xi.item.FUKURO,                20000 },
            { xi.item.CUSTODES,              20000 },
            { xi.item.MILITARY_SPEAR,        20000 },
            { xi.item.ARTEMISS_WAND,         20000 },
            { xi.item.DOLPHIN_STAFF,         20000 },
            { xi.item.GARDE_PICK,            10000 },
            { xi.item.MYTHRIL_DAGGER_P1,     10000 },
            { xi.item.SCROLL_OF_SILENA,      2000 },
            { xi.item.CARECT_RING,           191 },
            { xi.item.DART,                  9 },
            { xi.item.IRON_ARROW,            7 },
            { xi.item.CROSSBOW_BOLT,         5 },
            { xi.item.WOODEN_ARROW,          3 },
        })
    elseif inZones(zones28) and plevel >= 28 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.RAJAS_RING,          2000000 },
            { xi.item.TAMAS_RING,          2000000 },
            { xi.item.SATTVA_RING,         2000000 },
            { xi.item.BUCCANEERS_SCIMITAR, 30000 },
            { xi.item.TORTOISE_SHIELD,     30000 },
            { xi.item.DEMONIC_SWORD,       30000 },
            { xi.item.MOKUSA,              30000 },
            { xi.item.RISKY_PATCH,         30000 },
            { xi.item.MYCOPHILE_CUFFS,     30000 },
            { xi.item.RAMBLERS_GAITERS,    30000 },
            { xi.item.MINSTRELS_DAGGER,    30000 },
            { xi.item.SWEET_SACHET,        20000 },
            { xi.item.OLIBANUM_SACHET,     20000 },
            { xi.item.MUSK_SACHET,         20000 },
            { xi.item.MILLEFLEURS_SACHET,  20000 },
            { xi.item.CIVET_SACHET,        20000 },
            { xi.item.BALM_SACHET,         20000 },
            { xi.item.ATTAR_SACHET,        20000 },
            { xi.item.THUGS_JAMBIYA,       20000 },
            { xi.item.MELAMPUS_STAFF,      20000 },
            { xi.item.HAMAYUMI,            20000 },
            { xi.item.ASTAROTH_CANE,       20000 },
            { xi.item.DART,                9 },
            { xi.item.IRON_ARROW,          7 },
            { xi.item.CROSSBOW_BOLT,       5 },
            { xi.item.WOODEN_ARROW,        3 },
        })
    elseif inZones(zones38) and plevel >= 38 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.VAMPIRIC_CLAWS,      40000 },
            { xi.item.VOYAGER_SALLET,      40000 },
            { xi.item.RAIN_HAT,            40000 },
            { xi.item.RESENTMENT_CAPE,     40000 },
            { xi.item.VELMAS_RING,         40000 },
            { xi.item.LUZAFS_RING,         40000 },
            { xi.item.INTRUDER_EARRING,    40000 },
            { xi.item.CASABA_MELON_TANK,   40000 },
            { xi.item.HORNETNEEDLE,        40000 },
            { xi.item.FLASK_OF_ECHO_DROPS, 800 },
            { xi.item.DART,                9 },
            { xi.item.IRON_ARROW,          7 },
            { xi.item.CROSSBOW_BOLT,       5 },
            { xi.item.WOODEN_ARROW,        3 },
        })
    elseif inZones(zones48) and plevel >= 48 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.SOBORO_SUKEHIRO,     50000 },
            { xi.item.SCHWARZ_AXT,         50000 },
            { xi.item.IMMORTALS_SHOTEL,    50000 },
            { xi.item.HOTOTOGISU,          50000 },
            { xi.item.GALKAN_DAGGER,       50000 },
            { xi.item.BIRDBANES,           50000 },
            { xi.item.CORSAIRS_KNIFE,      50000 },
            { xi.item.SENTINEL_SHIELD,     50000 },
            { xi.item.SWIFT_BELT,          50000 },
            { xi.item.JALZAHNS_RING,       50000 },
            { xi.item.STORM_ZUCCHETTO,     50000 },
            { xi.item.STORM_MANOPOLAS,     50000 },
            { xi.item.STORM_GAMBIERAS,     50000 },
            { xi.item.PARADE_CUIRASS,      50000 },
            { xi.item.RAPPAREE_HARNESS,    50000 },
            { xi.item.GLOOM_BREASTPLATE,   50000 },
            { xi.item.GAUDY_HARNESS,       50000 },
            { xi.item.WYVERN_MAIL,         50000 },
            { xi.item.NOKIZARU_GI,         50000 },
            { xi.item.SHIKAREE_AKETON,     50000 },
            { xi.item.SHINIMUSHA_HARA_ATE, 50000 },
            { xi.item.GLAMOR_JUPON,        50000 },
            { xi.item.AIKIDO_GI,           50000 },
            { xi.item.CERISE_DOUBLET,      50000 },
            { xi.item.DUENDE_COTEHARDIE,   50000 },
            { xi.item.NIMBUS_DOUBLET,      50000 },
            { xi.item.DART,                9 },
            { xi.item.IRON_ARROW,          7 },
            { xi.item.CROSSBOW_BOLT,       5 },
            { xi.item.WOODEN_ARROW,        3 },
        })
    elseif inZones(zones58) and plevel >= 58 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.POTENT_BELT,         200000 },
            { xi.item.VASSAGOS_SCYTHE,     100000 },
            { xi.item.TUNGI,               60000 },
            { xi.item.CALAMAR,             60000 },
            { xi.item.LOXLEY_BOW,          60000 },
            { xi.item.SHARK_GUN,           60000 },
            { xi.item.BULL_NECKLACE,       60000 },
            { xi.item.COUGAR_PENDANT,      60000 },
            { xi.item.CROCODILE_COLLAR,    60000 },
            { xi.item.SHIELD_COLLAR,       60000 },
            { xi.item.THRAKON_BREASTPLATE, 60000 },
            { xi.item.VIVIAN_RING,         60000 },
            { xi.item.SUKESADA,            60000 },
            { xi.item.LYRICISTS_GONNELLE,  60000 },
            { xi.item.POWER_STAFF,         60000 },
            { xi.item.ARONDIGHT,           60000 },
            { xi.item.SLEIGHT_KUKRI,       60000 },
            { xi.item.ASKLEPIOS,           60000 },
            { xi.item.LIEUTENANTS_GORGET,  60000 },
            { xi.item.CURSE_WAND,          60000 },
            { xi.item.IFRITS_BLADE,        60000 },
            { xi.item.GARUDAS_DAGGER,      60000 },
            { xi.item.SHIVAS_CLAWS,        60000 },
            { xi.item.OPO_OPO_CROWN,       60000 },
            { xi.item.DART,                9 },
            { xi.item.IRON_ARROW,          7 },
            { xi.item.CROSSBOW_BOLT,       5 },
            { xi.item.WOODEN_ARROW,        3 },
        })
    elseif inZones(zones65) and plevel >= 65 then
        player:printToPlayer('Mentor Status Confirmed: Opening Shop...', xi.msg.channel.SAY, 'Moogle')
        xi.shop.general(player,
        {
            { xi.item.COURSERS_PUGIO,          70000 },
            { xi.item.DAINSLAIF,               70000 },
            { xi.item.SIROCCO_KUKRI,           70000 },
            { xi.item.ASCALON,                 70000 },
            { xi.item.ERIKS_AXE,               70000 },
            { xi.item.NARVAL,                  70000 },
            { xi.item.SUKESADA,                70000 },
            { xi.item.IMANOTSURUGI,            70000 },
            { xi.item.OTHINUS_BOW,             70000 },
            { xi.item.ASTROLABE,               70000 },
            { xi.item.IRON_RAM_SALLET,         70000 },
            { xi.item.IRON_RAM_HAUBERK,        70000 },
            { xi.item.IRON_RAM_DASTANAS,       70000 },
            { xi.item.IRON_RAM_HOSE,           70000 },
            { xi.item.IRON_RAM_GREAVES,        70000 },
            { xi.item.FOURTH_DIVISION_HAUBE,   70000 },
            { xi.item.FOURTH_DIVISION_BRUNNE,  70000 },
            { xi.item.FOURTH_DIVISION_HENTZES, 70000 },
            { xi.item.FOURTH_DIVISION_SCHOSS,  70000 },
            { xi.item.FOURTH_DIVISION_SCHUHS,  70000 },
            { xi.item.COBRA_UNIT_CAP,          70000 },
            { xi.item.COBRA_UNIT_HARNESS,      70000 },
            { xi.item.COBRA_UNIT_MITTENS,      70000 },
            { xi.item.COBRA_UNIT_SUBLIGAR,     70000 },
            { xi.item.COBRA_UNIT_LEGGINGS,     70000 },
            { xi.item.COBRA_UNIT_CLOCHE,       70000 },
            { xi.item.COBRA_UNIT_ROBE,         70000 },
            { xi.item.COBRA_UNIT_GLOVES,       70000 },
            { xi.item.COBRA_UNIT_TREWS,        70000 },
            { xi.item.COBRA_UNIT_CRACKOWS,     70000 },
            { xi.item.DART,                    9 },
            { xi.item.IRON_ARROW,              7 },
            { xi.item.CROSSBOW_BOLT,           5 },
            { xi.item.WOODEN_ARROW,            3 },
        })
    else
        player:printToPlayer('Hmm... You might need to level up more for me to sell you items, kupo!', xi.msg.channel.SAY, 'Moogle')
    end
end

return xi.mentor
